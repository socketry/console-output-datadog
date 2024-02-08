# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2023, by Samuel Williams.
# Copyright, 2022, by Catalino Cuadrado.

require 'ddtrace'
# frozen_string_literal: true

# Copyright, 2021, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# frozen_string_literal: true

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
					# 128-bit tracing is not supported by the Datadog agent, so we need to convert it to 64-bit. We expect that this will be changed in the future.
					::Datadog::Tracing::Utils::TraceId.to_low_order(id)
				end
			end
		end
	end
end
