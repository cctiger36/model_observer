module ModelObserver
  module ActiveRecord
    class << self
      def enable
        require 'active_record'
        overwrite_instantiate
        overwrite_find_by_sql
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

      def overwrite_find_by_sql
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
end
