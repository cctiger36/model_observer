require 'model_observer/dependency'
require 'model_observer/railtie'

module ModelObserver
  extend Dependency

  autoload :Metric, 'model_observer/metric'
  autoload :Collector, 'model_observer/collector'
  autoload :Analyser, 'model_observer/analyser'
  autoload :Rack, 'model_observer/rack'

  if active_record?
    autoload :ActiveRecord, 'model_observer/active_record'
    ModelObserver::ActiveRecord.enable
  end

  class << self
    def start_request
    end

    def end_request
      Collector.clear
    end

    def write_to_rails_log
      Rails.logger.warn "===== Model Observer Start ====="
      Rails.logger.warn Analyser.result
      Rails.logger.warn "===== Model Observer End ====="
    end
  end
end
