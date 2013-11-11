module ModelObserver
  module ActiveRecord
    class << self
      def enable
        require 'active_record'
        require 'model_observer/querying'
        overwrite_instantiate
      end

      def overwrite_instantiate
        ::ActiveRecord::Persistence::ClassMethods.class_eval do
          alias_method :origin_instantiate, :instantiate

          def instantiate(record, column_types = {})
            started_at = Time.now
            instance = origin_instantiate(record, column_types)
            ModelObserver::Collector.add_metric(ModelObserver::Metric.new(instance, started_at, Time.now))
            instance
          end
        end
      end
    end
  end
end
