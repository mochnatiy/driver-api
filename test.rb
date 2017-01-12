ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require File.expand_path '../app.rb', __FILE__

class AppTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root_url
    get '/'
    assert last_response.ok?
    assert_equal 'Application is up!', last_response.body
  end
end
