require 'spec_helper'

module ModelObserver
  describe Collector do
    after(:each) { Collector.clear }

    context "find model" do
      before(:all) do
        Author.find(1)
      end

      it "should collect the metric of model creation" do
        Collector.metrics.size.should == 1
      end
    end
  end
end
