# frozen_string_literal: true

require 'console/logger'
require 'console/output/datadog'

RSpec.describe Console::Output::Datadog do
	it "has a version number" do
		expect(Console::Output::Datadog::VERSION).not_to be nil
	end
	
	let(:buffer) {double(call: nil)}
	let(:output) {described_class.new(buffer)}
	let(:logger) {Console::Logger.new(output)}
	
	context "without datadog trace" do
		it "should log message with datadog correlation" do
			expect(buffer).to receive(:call).with("Hello World", {severity: :info})
			
			logger.info("Hello World")
		end
	end
	
	context "within datadog trace" do
		it "should log message with datadog correlation" do
			Datadog::Tracing.trace("frobulate.apply",service: "frobulate") do |span|
				expect(buffer).to receive(:call).with("Hello World", {
					severity: :info,
					dd: {
						trace_id: span.trace_id.to_s,
						span_id: span.id.to_s
					}
				})
				
				logger.info("Hello World")
			end
		end
	end
end
