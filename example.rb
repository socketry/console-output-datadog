#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/console/output/datadog'

require 'console'
require 'ddtrace'

Datadog.tracer.trace("log.test") do |span|
	Console.logger.warn(self, "Hello World")
	
	begin
		raise "Boom"
	rescue => error
		Console.logger.error(self, error)
	end
end
