require 'httparty'

module ExceptIO
  class Client
    include HTTParty

    def self.configure(application, app_key, endpoint = 'except.io')
      @application = application
      @app_key = app_key
      @configured = true
      base_uri endpoint
      if defined?(Rails)
        if Rails.version.starts_with?("2.3")
          ActionController::Base.send(:include, ExceptIO::Hooks::Rails23)
        elsif Rails.version.starts_with?("3")
          ActionController::Base.send(:include, ExceptIO::Hooks::Rails3)
        end
      end
    end

    def self.reset!
      @application = nil
      @app_key = nil
      @configured = false
    end

    def self.log(exception, environment = "production", params = {}, session = {}, request_url = nil)
      return false unless @configured
      res = self.post("/applications/#{@application}/errors", {:query => {:app_key => @app_key}, :body => {:error => {:message => exception.message, :backtrace => exception.backtrace, :environment => environment, :params => params, :session => session, :request_url => request_url}}})
      res.code == 201
    end
  end
end
