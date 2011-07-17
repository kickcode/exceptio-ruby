require 'httparty'

module ExceptIO
  class Client
    include HTTParty

    base_uri 'exceptio.local:3000'

    def self.configure(application, app_key)
      @application = application
      @app_key = app_key
      if defined?(Rails)
        if Rails.version.starts_with?("2.3")
          ActionController::Base.send(:include, ExceptIO::Hooks::Rails23)
        elsif Rails.version.starts_with?("3")
          ActionController::Base.send(:include, ExceptIO::Hooks::Rails3)
        end
      end
    end

    def self.log(exception)
      self.post("/applications/#{@application}/errors", {:query => {:app_key => @app_key}, :body => {:error => {:message => exception.message, :backtrace => exception.backtrace}}})
    end
  end
end
