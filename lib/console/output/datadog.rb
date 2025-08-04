# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2023, by Samuel Williams.

begin
	require "datadog"
rescue LoadError
	# Ignore.
end

require_relative "datadog/wrapper"

module Console
	module Output
		# The reason why this is a serialized logger rather than an output filter, is because it needs to directly modify the top level of the record.
		module Datadog
			def self.new(output, **options)
				if Object.const_defined?(:Datadog)
					Wrapper.new(output)
				else
					output
				end
			end
		end
	end
end
