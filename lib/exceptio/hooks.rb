module ExceptIO
  module Hooks
    module Rails23
      def log_error(exception)
        ExceptIO::Client.log(exception)
      end
    end

    module Rails3
      def rescue_to_exceptio(exception = nil)
        ExceptIO::Client.log(exception)
        raise exception
      end

      def self.included(klass)
        klass.rescue_from Exception, :with => :rescue_to_exceptio
      end
    end
  end
end
