require 'spec_helper'

module ModelObserver
  describe Rack do
    let(:app) { Support::AppDouble.new }
    let(:middleware) { ModelObserver::Rack.new app }

    context "#call" do
      before do
        logger = double("logger")
        logger.stub(:warn).with(an_instance_of(String))
        Rails.stub(:logger).and_return(logger)
      end

      it "should invoke ModelObserver.start_request and ModelObserver.end_request" do
        ModelObserver.should_receive(:start_request)
        ModelObserver.should_receive(:end_request)
        middleware.call([])
      end

      it "should return original response body" do
        expected_response = Support::ResponseDouble.new "Actual body"
        app.response = expected_response
        status, headers, response = middleware.call([])
        response.should == expected_response
      end

      it "should write analysed result to rails log" do
        Rails.logger.should_receive(:warn).with(an_instance_of(String))
        middleware.call([])
      end
    end
  end
end
