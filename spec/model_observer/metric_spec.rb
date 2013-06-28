require 'spec_helper'

module ModelObserver
  describe Metric do
    let(:metric) do
      Author.find(1)
      Collector.metrics.first
    end
    after(:each) { Collector.clear }

    it "should log the duration of object creation" do
      metric.duration.should >= 0
    end
  end
end
