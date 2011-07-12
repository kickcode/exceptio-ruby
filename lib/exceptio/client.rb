require 'httparty'

module ExceptIO
  class Client
    include HTTParty

    base_uri 'exceptio.local:3000'

    def self.configure(application)
      @application = application
    end

    def self.log(exception)
      self.post("/applications/#{@application}/errors", {:body => {:error => {:message => exception.message, :backtrace => exception.backtrace}}})
    end
  end
end
