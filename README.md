This is a very basic [Sinatra](https://github.com/sinatra/sinatra) app showing how to get started with Xero's oficially supported Ruby SDK to access their API's
*Sinatra is a DSL (Domain Specific Language) for quickly creating web applications in Ruby with minimal effort*

Main Library
> [xero-ruby](https://github.com/XeroAPI/xero-ruby)

# Requirements
> ruby 2.7

# Pre-requesites
1) Create an app in Xero's developer portal
> https://developer.xero.com/myapps/

2) Decide what `scopes` your application needs
> https://developer.xero.com/documentation/oauth2/scopes

3) Rename `sample.env` to `.env` and replace with the **4 required parameters**

# run the app
```bash
$ bundle install
$ bundle exec ruby xero_app.rb
```

Visit `http://localhost:4567/` and start exploring the code 🥳


## Example Code
Setting up and connecting to the XeroAPI with the `xero-ruby` SDK is simple

```ruby
def xero_client
  creds = {
    client_id: ENV['CLIENT_ID'],
    client_secret: ENV['CLIENT_SECRET'],
    redirect_uri: 'http://localhost:4567/auth/callback',
    scopes: ENV['SCOPES']
  }
  XeroRuby::ApiClient.new(credentials: creds)
end


get '/auth' do
  redirect to(xero_client.authorization_url)
end

get '/auth/callback' do
  xero_client.get_token_set_from_callback(params)
  tenant_id = xero_client.connections.last['tenantId']
  @invoices = xero_client.accounting_api.get_invoices(tenant_id).invoices
end
```

Checkout `xero_app.rb` for all the sample code you need to get started for your own app
