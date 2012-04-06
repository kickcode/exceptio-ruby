require 'test/unit'
gem 'fakeweb'
require 'fakeweb'
gem 'mocha'
require 'mocha'
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "lib", "exceptio", "client")

module ActiveRecord
  class RecordNotFound < Exception; end
end
class MyCustomIgnoredError < Exception; end

class ClientTest < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
    ExceptIO::Client.reset!
  end

  def test_exception_log
    expect_http_request
    ExceptIO::Client.configure "testing", "12345"
    assert_equal true, ExceptIO::Client.log(create_exception)
  end

  def test_no_configure_exception_log
    assert_equal false, ExceptIO::Client.log(create_exception)
  end

  def test_exception_ignored_by_default
    ExceptIO::Client.configure "testing", "12345"
    assert_equal false, ExceptIO::Client.log(create_exception(ActiveRecord::RecordNotFound))
  end

  def test_custom_exception_ignored_add_to_defaults
    ExceptIO::Client.configure "testing", "12345"
    ExceptIO::Client.ignored_exceptions << MyCustomIgnoredError
    assert_equal false, ExceptIO::Client.log(create_exception(MyCustomIgnoredError))
    assert_equal false, ExceptIO::Client.log(create_exception(ActiveRecord::RecordNotFound))
  end

  def test_custom_exception_ignored_override_defaults
    expect_http_request
    ExceptIO::Client.configure "testing", "12345"
    ExceptIO::Client.ignored_exceptions = [MyCustomIgnoredError]
    assert_equal false, ExceptIO::Client.log(create_exception(MyCustomIgnoredError))
    assert_equal true, ExceptIO::Client.log(create_exception(ActiveRecord::RecordNotFound))
  end  

  def expect_http_request
    response = Net::HTTPOK.new("1.1", 201, "CREATED")
    response.instance_variable_set(:@read, true)
    Net::HTTP.any_instance.expects(:request).with do |request|
      request.path == "/applications/testing/errors?app_key=12345" && request.method == "POST"
    end.returns(response)
  end

  def create_exception(klass = Exception)
    begin
      raise klass.new("testing")
    rescue Exception => ex
      @ex = ex
    end
    @ex
  end    
end
