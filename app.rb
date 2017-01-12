require 'rubygems'
require 'bundler'
require 'json'

require './models/user'
require './models/task'

Bundler.require(:default)

configure do
  Mongoid.load!('./database.yml', :development)
end

before do
  if request.body.size > 0
    request.body.rewind
    @params = JSON.parse(request.body.read)
  end
end

before do
  next if request.path_info == '/' 
  
  begin
    @current_user = User.find_by(token: params['token'])
  rescue Mongoid::Errors::DocumentNotFound
    halt(
      401,
      {'Content-Type' => 'json'},
      { result: :fail, message: 'Authorization is not successful' }.to_json
    )
  end
end

# Root url
get '/' do
  'Application is up!'
end

# Create tasks by manager
post '/tasks' do
  content_type :json
  
  # TODO: Provide a separate filter for access rights
  if @current_user.access_level == 'driver'
    halt(
      403,
      {'Content-Type' => 'json'},
      { result: :fail, message: 'You have no permissions to do this' }.to_json
    )
  end
  
  # TODO: Provide validations there
  Task.create(
    number: params['tasks']['number'],
    status: 'New',
    pickup: params['tasks']['pickup'],
    delivery: params['tasks']['delivery']
  )
  
  { result: :ok, message: 'The task has been created' }.to_json
end

# Get list of tasks by driver
get '/tasks' do
  driver_location = Point.new(params['lat'], params['long'])
  
  result_set = []
  
  Task.each do |task|
    result_set << {
      number: task.number,
      distance: task.plane_distance(driver_location)
    }
  end
  
  result_set.sort_by! { |k| k[:distance] }
  
  { tasks: result_set.map{ |i| i[:number] } }.to_json
end

# Assign a task to driver
post '/tasks/pick' do
  if @current_user.access_level == 'manager'
    halt(
      403,
      {'Content-Type' => 'json'},
      { result: :fail, message: 'You have no permissions to do this' }.to_json
    )
  end
  
  begin
    task = Task.find_by(number: params['number'])
    task.update(status: 'Assigned')
    { result: :ok, message: 'The task has been assigned to driver' }.to_json
  rescue Mongoid::Errors::DocumentNotFound
    halt(
      404,
      {'Content-Type' => 'json'},
      { result: :fail, message: 'The task is not exist' }.to_json
    )
  end
end

# Complete a task by driver
post '/tasks/complete' do
  if @current_user.access_level == 'manager'
    halt(
      403,
      {'Content-Type' => 'json'},
      { result: :fail, message: 'You have no permissions to do this' }.to_json
    )
  end
  
  begin
    task = Task.find_by(number: params['number'])
    task.update(status: 'Done')
    { result: :ok, message: 'The task has been completed by driver' }.to_json
  rescue Mongoid::Errors::DocumentNotFound
    halt(
      404,
      {'Content-Type' => 'json'},
      { result: :fail, message: 'The task is not exist' }.to_json
    )
  end
end
