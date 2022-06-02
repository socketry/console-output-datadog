# frozen_string_literal: true

require "bundler/setup"
require "console/output/datadog"
require 'ddtrace'

Datadog.configure do |c|
	c.tracing.enabled = true
	
	# To enable debug mode
	c.diagnostics.debug = true
end

RSpec.configure do |config|
	# Enable flags like --only-failures and --next-failure
	config.example_status_persistence_file_path = ".rspec_status"
	
	# Disable RSpec exposing methods globally on `Module` and `main`
	config.disable_monkey_patching!
	
	config.expect_with :rspec do |c|
		c.syntax = :expect
	end
end
