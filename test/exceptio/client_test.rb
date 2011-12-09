require 'test/unit'
gem 'fakeweb'
require 'fakeweb'
gem 'mocha'
require 'mocha'
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "lib", "exceptio", "client")

class ClientTest < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
    ExceptIO::Client.configure "testing", "12345"
  end

  def test_exception_log
    begin
      raise "testing"
    rescue Exception => ex
      @ex = ex
    end
    expect_http_request
    assert_equal true, ExceptIO::Client.log(@ex)
  end

  def expect_http_request
    response = Net::HTTPOK.new("1.1", 201, "CREATED")
    response.instance_variable_set(:@read, true)
    Net::HTTP.any_instance.expects(:request).with do |request|
      request.path == "/applications/testing/errors?app_key=12345" && request.method == "POST"
    end.returns(response)
  end
end
