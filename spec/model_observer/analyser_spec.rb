require 'spec_helper'

module ModelObserver
  describe Analyser do
    context ".result" do
      after { Collector.clear }
      it "should return the model creation infos" do
        Author.find(1)
        ModelObserver::Analyser.result.should =~ /^Author: 1 sum\(\d+\.\d+ms\) avg\(\d+\.\d+ms\)$/
      end

      it "should record duplicated model creations" do
        2.times { Author.find(1) }
        ModelObserver::Analyser.result.should include("id(1): 2")
      end
    end
  end
end
