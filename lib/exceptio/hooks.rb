module ExceptIO
  module Hooks
    def rescue_to_exceptio(exception = nil)
      ExceptIO::Client.log(exception)
      raise exception
    end

    def self.included(klass)
      klass.rescue_from Exception, :with => :rescue_to_exceptio
    end
  end
end
