require 'minitest/autorun'
require 'sinatra/base'
require 'rack/test'
require 'sinatra/namespace'

class App < Sinatra::Base
  register Sinatra::Namespace

  namespace '/foo/:year/?:period?' do
    get '/status' do
      status 200
    end

    namespace '/nested' do
      get '/1' do
        this_method_does_not_exist('hello')
        status 200
      end

      helpers do
        def this_method_does_not_exist(msg)
          puts "hello #{msg}"
        end
      end
    end
  end
end

class NestedNamespacesTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def test_year
    get '/foo/2018/status'

    assert_equal last_response.status, 200
  end

  def test_year_month
    get '/foo/2018/2/status'

    assert_equal last_response.status, 200
  end

  def test_year_nested_namespace
    get '/foo/2018/nested/1'

    assert_equal last_response.status, 200, last_response.body
  end

  def test_year_month_nested_namespace
    get '/foo/2018/2/nested/1'

    assert_equal last_response.status, 200
  end

end
