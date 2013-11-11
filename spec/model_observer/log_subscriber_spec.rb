require 'spec_helper'
require "active_support/log_subscriber/test_helper"

class TestDebugLogSubscriber < ModelObserver::LogSubscriber
  attr_reader :debugs

  def initialize
    @debugs = []
    super
  end

  def debug(message)
    @debugs << message
  end
end

module ModelObserver
  describe LogSubscriber do
    before(:all) do
      @old_logger = ::ActiveRecord::Base.logger
      ::ActiveRecord::Base.logger = ActiveSupport::LogSubscriber::TestHelper::MockLogger.new
    end

    after(:all) do
      ::ActiveRecord::Base.logger = @old_logger
    end

    let(:logger) { TestDebugLogSubscriber.new }

    it "should add instantiate logs" do
      event = Struct.new(:duration, :payload)

      logger.instantiate(event.new(1.1, sql: 'foo', name: 'Author Load'))
      expect(logger.debugs.size).to eq(1)
      expect(logger.debugs.last).to match(/^  .*Author Load \(1\.1ms\).*  .*foo.*/)
    end
  end
end
