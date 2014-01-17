require 'model_observer/dependency'
require 'model_observer/railtie'

module ModelObserver
  extend Dependency

  autoload :Metric, 'model_observer/metric'
  autoload :Collector, 'model_observer/collector'
  autoload :Analyser, 'model_observer/analyser'
  autoload :Rack, 'model_observer/rack'

  attr_writer :summary, :instantiation_log

  class << self
    def summary?
      @summary
    end

    def instantiation_log?
      @instantiation_log
    end

    def summary=(bool)
      @summary = bool
      if summary?
        if active_record?
          if active_record4?
            autoload :ActiveRecord, 'model_observer/active_record4'
            ModelObserver::ActiveRecord.enable
          elsif active_record3?
            autoload :ActiveRecord, 'model_observer/active_record3'
            ModelObserver::ActiveRecord.enable
          else
            raise "Current version of active_record is not supported."
          end
        end
      end
    end

    def instantiation_log=(bool)
      @instantiation_log = bool
      if instantiation_log?
        if active_record?
          require 'model_observer/log_subscriber'
        end
      end
    end

    def start_request
    end

    def end_request
      Collector.clear
    end

    def write_to_rails_log
      Rails.logger.warn "===== Model Observer Start ====="
      Rails.logger.warn Analyser.result
      Rails.logger.warn "===== Model Observer End ======="
    end
  end
end
