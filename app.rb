require 'rubygems'
require 'bundler'

Bundler.require(:default)

configure do
  Mongoid.load!('./database.yml', :development)
end

# Root url
get '/' do
  "Application is up: #{Time.now}"
end

# Create tasks by manager
post 'tasks/' do
end

# Get list of tasks by driver
get 'tasks/' do
end

# Assign a task to driver
post 'tasks/:id/pick' do
end

# Complete a task by driver
post 'tasks/:id/complete' do
end
