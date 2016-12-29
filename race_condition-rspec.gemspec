# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'race_condition/rspec/version'

Gem::Specification.new do |spec|
  spec.name          = "race_condition-rspec"
  spec.version       = RaceCondition::Rspec::VERSION
  spec.authors       = ["Ryan Boland"]
  spec.email         = ["bolandryanm@gmail.com"]
  spec.summary       = "RSpec client for sending test suite results to RaceCondition."
  spec.description   = "RSpec client for sending test suite results to RaceCondition."
  spec.homepage      = "https://github.com/RaceCondition-io/race_condition-rspec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "pry"
end
