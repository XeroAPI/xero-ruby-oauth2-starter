This is a very basic [Sinatra](https://github.com/sinatra/sinatra) app showing how to get started with Xero's oficially supported Ruby SDK to access their API's.
*Sinatra is a DSL (Domain Specific Language) for quickly creating web applications in Ruby with minimal effort*

Main Library
> [xero-ruby](https://github.com/XeroAPI/xero-ruby)

# Requirements
> ruby 2.7

# Pre-requesites
`) Create an app in Xero's developer portal
> https://developer.xero.com/myapps/

2) Decide what `scopes` your application needs.
> https://developer.xero.com/documentation/oauth2/scopes

3) Rename `sample.env` to `.env` and replace with the **4 required parameters**.

# run the app
$ bundle install
$ bundle exec ruby xero_app.rb
