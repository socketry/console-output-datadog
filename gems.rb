# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2024, by Samuel Williams.

source "https://rubygems.org"

gemspec

group :maintenance, optional: true do
	gem "bake-gem"
	gem "bake-modernize"
	
	gem "bake-github-pages"
	gem "utopia-project"
end

group :test do
	gem "bake-test"
	gem "bake-test-external"
	
	gem "sus"
	gem "covered"
	
	# `::Datadog::Tracing::Utils::TraceId.to_low_order` is introduced in 1.10.0:
	# https://github.com/DataDog/dd-trace-rb/pull/2543/files#diff-634ece3c2962088040f7d60ec5c895212f6083ac241310a0c5bf0edb645d300f
	# But `Identifier#trace_id` which is used by the tests is introduced in 1.13.0:
	# https://github.com/DataDog/dd-trace-rb/pull/2974
	gem "ddtrace", "~> 1.13"
end
