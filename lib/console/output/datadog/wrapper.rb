# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2025, by Samuel Williams.
# Copyright, 2022, by Catalino Cuadrado.

module Console
	module Output
		# The reason why this is a serialized logger rather than an output filter, is because it needs to directly modify the top level of the record.
		module Datadog
			class Wrapper
				def initialize(output)
					@output = output
				end
				
				def call(subject = nil, *arguments, **options, &block)
					if trace = ::Datadog::Tracing.active_trace
						# This does a bunch of allocations, so we avoid using this interface:
						# correlation = ::Datadog::Tracing.correlation
						
						if span = trace.active_span
							options[:dd] = {
								span_id: span.id.to_s,
								trace_id: format_trace_id(trace.id)
							}
						else
							options[:dd] = {
								trace_id: format_trace_id(trace.id)
							}
						end
					end
					
					@output.call(subject, *arguments, **options, &block)
				end
				
				private
				
				def format_trace_id(id)
					::Datadog::Tracing::Correlation.format_trace_id(id)
				end
			end
		end
	end
end
