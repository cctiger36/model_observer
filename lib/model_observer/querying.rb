module ModelObserver
  module Querying
    ::ActiveRecord::Querying.class_eval do
      alias_method :origin_find_by_sql, :find_by_sql

      def find_by_sql(sql, binds = [])
        ::ActiveSupport::Notifications.instrumenter.instrument(
          "instantiate.active_record",
          :sql   => sql,
          :name  => "#{name} Load") { origin_find_by_sql }
      end
    end
  end
end
