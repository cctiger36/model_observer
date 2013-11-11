require 'active_record/log_subscriber'

module ModelObserver
  class LogSubscriber < ::ActiveRecord::LogSubscriber
    def instantiate(event)
      return unless logger.debug?

      payload = event.payload
      name = '%s (%.1fms)' % [payload[:name], event.duration]
      sql  = payload[:sql].squeeze(' ')

      name = color(name, YELLOW, true)
      sql  = color(sql, nil, true)
      debug "  #{name}  #{sql}"
    end
  end
end

ModelObserver::LogSubscriber.attach_to :model_observer
