require 'spec_helper'

module ModelObserver
  describe "#find_by_sql" do
    it "should publish notifications of instantiation when #find_by_sql called" do
      expect(ActiveSupport::Notifications.instrumenter).to receive(:instrument).with("instantiate.model_observer", kind_of(Hash))
      Author.all.to_a
    end
  end
end
