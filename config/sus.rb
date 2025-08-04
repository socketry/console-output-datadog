# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2024, by Samuel Williams.
# Copyright, 2022, by Catalino Cuadrado.

require "datadog"

Datadog.configure do |config|
	config.tracing.enabled = true
	
	# To enable debug mode
	config.diagnostics.debug = false
	
	# # Set transport to no-op mode. Does not retain traces.
	# config.tracing.transport_options = proc {|t| t.adapter :test}
	# Silence low-severity Datadog log messages
	config.logger.level = Logger::ERROR
end
