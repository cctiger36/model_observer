module ModelObserver
  class Railtie < Rails::Railtie
    initializer "model_observer.configure_rails_initialization" do |app|
      app.middleware.use ModelObserver::Rack
    end
  end
end
