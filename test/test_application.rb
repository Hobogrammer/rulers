require_relative "test_helper"

class TestController < Rulers::Controller
  def index
    "Hello"
  end
end

class TestApp < Rulers::Application
  def get_controller_and_action(env)
    [TestController, "index"]
  end
end

class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/example/route"

    assert last_response.ok?
    body = last_response.body
    assert body["Hello"]
  end

  def test_content
    get "/example/route"

    assert last_response.content_type =='text/html'
  end
end
