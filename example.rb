#!/usr/bin/env ruby
# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2023, by Samuel Williams.

require_relative "lib/console/output/datadog"

require "console"

Datadog.tracer.trace("log.test") do |span|
	Console.logger.warn(self, "Hello World")
	
	begin
		raise "Boom"
	rescue => error
		Console.logger.error(self, error)
	end
end
