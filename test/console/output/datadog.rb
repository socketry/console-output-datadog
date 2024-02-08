# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2023, by Samuel Williams.
# Copyright, 2022, by Catalino Cuadrado.

require 'console/logger'
require 'console/capture'
require 'console/output/datadog'

describe Console::Output::Datadog do
	it "has a version number" do
		expect(Console::Output::Datadog::VERSION).to be =~ /\d+\.\d+\.\d+/
	end
	
	let(:buffer) {Console::Capture.new}
	let(:output) {subject.new(buffer)}
	let(:logger) {Console::Logger.new(output)}
	
	it "should log message without datadog correlation" do
		expect(buffer).to receive(:call).with("Hello World", severity: :info)
		
		logger.info("Hello World")
	end
	
	with "datadog trace" do
		def correlation_trace_id(span)
			::Datadog::Tracing::Correlation::Identifier.new(trace_id: span.trace_id).trace_id.to_s
		end
		
		it "should log message with datadog correlation" do
			Datadog::Tracing.trace("frobulate.apply",service: "frobulate") do |span|
				expect(buffer).to receive(:call).with("Hello World",
					severity: :info,
					dd: {
						trace_id: correlation_trace_id(span),
						span_id: span.id.to_s
					}
				)
				
				logger.info("Hello World")
			end
		end
		
		it "should log message with datadog correlation even if span is missing" do
			Datadog::Tracing.trace("frobulate.apply",service: "frobulate") do |span, trace|
				expect(trace).to receive(:active_span).and_return(nil)
				
				expect(buffer).to receive(:call).with("Hello World",
					severity: :info,
					dd: {
						trace_id: correlation_trace_id(span)
					}
				)
				
				logger.info("Hello World")
			end
		end
	end
end
