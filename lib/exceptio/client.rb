require 'httparty'

module ExceptIO
  class Client
    include HTTParty

    DEFAULT_IGNORED_EXCEPTIONS = ["ActiveRecord::RecordNotFound", "ActionController::InvalidAuthenticityToken", "ActionController::RoutingError"]

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

    def self.configured
      @configured
    end

    def self.application
      @application
    end

    def self.app_key
      @app_key
    end

    def self.ignored_exceptions
      @ignored_exceptions ||= DEFAULT_IGNORED_EXCEPTIONS.clone
    end

    def self.ignored_exceptions=(ignored_exceptions)
      @ignored_exceptions = ignored_exceptions
    end

    def self.reset!
      @application = nil
      @app_key = nil
      @configured = false
      @ignored_exceptions = DEFAULT_IGNORED_EXCEPTIONS.clone
    end

    def self.log(exception, environment = "production", params = {}, session = {}, request_url = nil)
      return false unless self.configured
      return false if self.ignored_exceptions.map(&:to_s).include?(exception.class.name)
      res = self.post("/applications/#{self.application}/errors", {:query => {:app_key => self.app_key}, :body => {:error => {:message => exception.message, :backtrace => exception.backtrace, :type => exception.class.name, :environment => environment, :params => params, :session => session, :request_url => request_url}}})
      res.code == 201
    end
  end
end
