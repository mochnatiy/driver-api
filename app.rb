require 'rubygems'
require 'bundler'

Bundler.require(:default)

configure do
  Mongoid.load!('./database.yml', :development)
end

get '/' do
  "Application is up: #{Time.now}"
end
