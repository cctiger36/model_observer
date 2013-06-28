require 'model_observer/dependency'

module ModelObserver
  extend Dependency

  if active_record?
    autoload :ActiveRecord, 'model_observer/active_record'
  end
  autoload :Metric, 'model_observer/metric'
  autoload :Collector, 'model_observer/collector'
  autoload :Analyser, 'model_observer/analyser'

  class << self
    def start_request
      Collector.clear
    end

    def end_request
    end
  end
end
