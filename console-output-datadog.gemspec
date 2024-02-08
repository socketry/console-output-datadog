# frozen_string_literal: true

require_relative "lib/console/output/datadog/version"

Gem::Specification.new do |spec|
	spec.name = "console-output-datadog"
	spec.version = Console::Output::Datadog::VERSION
	
	spec.summary = "Attach Datadog trace and span details to logs."
	spec.authors = ["Samuel Williams", "Catalino Cuadrado"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/socketry/console-output-datadog"
	
	spec.files = Dir.glob(['{lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 2.7"
	
	spec.add_dependency "console"
	spec.add_dependency "ddtrace", "~> 1.0"
end
