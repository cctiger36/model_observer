module ModelObserver
  module ActiveRecord
    def self.enable
      require 'active_record'

      ::ActiveRecord::Inheritance::ClassMethods.class_eval do
        alias_method :origin_instantiate, :instantiate

        def instantiate(record)
          started_at = Time.now
          instance = origin_instantiate(record)
          ModelObserver::Collector.add_metric(ModelObserver::Metric.new(instance, started_at, Time.now))
          instance
        end
      end

      ::ActiveRecord::Querying.class_eval do
        alias_method :origin_find_by_sql, :find_by_sql

        def find_by_sql(sql, binds = [])
          ::ActiveSupport::Notifications.instrumenter.instrument(
            "instantiate.model_observer",
            :sql   => connection.to_sql(sanitize_sql(sql), binds),
            :name  => "#{name} Instantiate") { origin_find_by_sql(sql, binds) }
        end
      end
    end
  end
end
