# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dodontor/version'

Gem::Specification.new do |spec|
  spec.name          = "dodontor"
  spec.version       = DodontoR::VERSION
  spec.authors       = ["deflis"]
  spec.email         = ["deflis@gmail.com"]
  spec.description   = %q{DodontoF on Rack}
  spec.summary       = %q{DodontoF on Rack}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
