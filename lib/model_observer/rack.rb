module ModelObserver
  class Rack
    def initialize(app)
      @app = app
    end

    def call(env)
      ModelObserver.start_request
      response = @app.call(env)
      ModelObserver.write_to_rails_log
      ModelObserver.end_request
      response
    end
  end
end
