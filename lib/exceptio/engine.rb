module ExceptIO
  class Engine < Rails::Engine
    initializer "exceptio.load", :after => :disable_dependency_loading do
      ExceptIO::Client.configure(File.basename(Rails.root))
      ActionController::Base.send(:include, ExceptIO::Hooks)
    end
  end
end
