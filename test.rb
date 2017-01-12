ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'json'

require File.expand_path '../app.rb', __FILE__

# TODO: Replace by rspec
class AppTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root_url_is_up_for_everyone
    get '/'
    assert last_response.ok?
    assert_equal 'Application is up!', last_response.body
  end
  
  def test_driver_cannot_create_tasks
    data = {
      token: 'e7dbeb877a9755ef64ae0eb70cab7ea7',
      tasks: {
        number: 500,
        pickup: [99, 173],
        delivery: [167, 215]
      }
    }
      
    post '/tasks', data.to_json, 'CONTENT_TYPE' => 'application/json'
    
    assert last_response.status == 403
    
    expected_result = {
      'result' => 'fail',
      'message' => 'You have no permissions to do this'
    }
    
    assert_equal JSON.parse(last_response.body), expected_result
  end
  
  def test_manager_cannot_pick_task
    data = {
      token: 'c1b643f56d14d5943861d6042567c278',
      number: 500
    }
      
    post '/tasks/pick', data.to_json, 'CONTENT_TYPE' => 'application/json'
    
    assert last_response.status == 403
    
    expected_result = {
      'result' => 'fail',
      'message' => 'You have no permissions to do this'
    }
    
    assert_equal JSON.parse(last_response.body), expected_result
  end
  
  def test_manager_cannot_complete_task
    data = {
      token: 'c1b643f56d14d5943861d6042567c278',
      number: 500
    }
      
    post '/tasks/complete', data.to_json, 'CONTENT_TYPE' => 'application/json'
    
    assert last_response.status == 403
    
    expected_result = {
      'result' => 'fail',
      'message' => 'You have no permissions to do this'
    }
    
    assert_equal JSON.parse(last_response.body), expected_result
  end
end
