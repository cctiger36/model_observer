module ModelObserver
  class Collector
    class << self
      def metrics
        @@metrics ||= []
      end

      def add_metric(metric)
        metrics << metric
      end

      def clear
        @@metrics = nil
      end

      def matrics_hash
        hash = {}
        matrics.each do |m|
          hash[m.model_class.name] ||= []
          hash[m.model_class.name] << m
        end
        hash
      end
    end
  end
end
