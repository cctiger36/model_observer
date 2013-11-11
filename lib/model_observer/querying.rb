::ActiveRecord::Querying.class_eval do
  alias_method :origin_find_by_sql, :find_by_sql

  def find_by_sql(sql, binds = [])
    ActiveSupport::Notifications.instrumenter.instrument(
      "instantiate.model_observer",
      :sql   => connection.to_sql(sanitize_sql(sql), binds),
      :name  => "#{name} Instantiate") { origin_find_by_sql(sql, binds) }
  end
end
