module ModelObserver
  class Analyser
    class << self
      def result
        text = ""
        Collector.metrics_hash.each do |key, value|
          sum_duration = value.map(&:duration).sum
          average_duration = sum_duration / value.count
          text << "#{key}: #{value.count} sum(#{sum_duration.round(1)}ms) avg(#{average_duration.round(1)}ms)\n"
          text << analyse_single_class(value)
        end
        text.sub!(/\n$/, '')
        text
      end

      def analyse_single_class(metrics)
        return if metrics.empty?
        primary_key = metrics.first.model_class.primary_key
        hash = {}
        metrics.each do |m|
          hash[m.model_id] ||= 0
          hash[m.model_id] += 1
        end
        hash
        text = ""
        hash.sort_by{|key, value| key}.each do |key, value|
          text << "  #{primary_key}(#{key}): #{value}\n" if value > 1
        end
        text
      end
    end
  end
end
