require 'sinatra'
require "sinatra/reloader" if development?
require 'xero-ruby'
require 'securerandom'
require 'dotenv/load'
require 'jwt'

set :session_secret, "328479283uf923fu8932fu923uf9832f23f232"
use Rack::Session::Pool
set :haml, :format => :html5

helpers do
  def xero_client
    creds = {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      redirect_uri: ENV['REDIRECT_URI'],
      scopes: ENV['SCOPES']
    }
    XeroRuby::ApiClient.new(credentials: creds)
  end
end

get '/' do
  @token_set = session[:token_set]
  @auth_url = xero_client.authorization_url

  if @token_set && @token_set['access_token']
    @access_token = JWT.decode @token_set['access_token'], nil, false
  end
  if @token_set && @token_set['id_token']
    @id_token =JWT.decode @token_set['id_token'], nil, false
  end

  haml :home
end

get '/add-connection' do
  @auth_url = xero_client.authorization_url
  redirect to(@auth_url)
end

get '/auth/callback' do
  @token_set = xero_client.get_token_set_from_callback(params)
  session[:token_set] = @token_set
  redirect to('/')
end

get '/refresh-token' do
  @token_set = xero_client.refresh_token_set(session[:token_set])
  session[:token_set] = @token_set

  if @token_set && @token_set['access_token']
    @access_token = JWT.decode @token_set['access_token'], nil, false
  end
  if @token_set && @token_set['id_token']
    @id_token =JWT.decode @token_set['id_token'], nil, false
  end

  haml :refresh_token
end

get '/disconnect' do
  xero_client.set_token_set(session[:token_set])
  xero_client.disconnect(xero_client.connections[0]['id'])
  @connections = xero_client.connections
  haml :disconnect
end

get '/connections' do
  xero_client.set_token_set(session[:token_set])
  @connections = xero_client.connections
  haml :connections
end

get '/invoices' do
  xero_client.set_token_set(session[:token_set])
  @invoices = xero_client.accounting_api.get_invoices(xero_client.connections[0]['tenantId']).invoices
  haml :invoices
end

get '/organisation' do
  xero_client.set_token_set(session[:token_set])
  @organisations = xero_client.accounting_api.get_organisations(xero_client.connections[0]['tenantId']).organisations
  haml :organisation
end