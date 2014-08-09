# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record_enumerated_type/version'

Gem::Specification.new do |spec|
  spec.name          = "active_record_enumerated_type"
  spec.version       = ActiveRecordEnumeratedType::VERSION
  spec.authors       = ["Ben Eddy"]
  spec.email         = ["bae@foraker.com"]
  spec.description   = %q{Enumerated types for ActiveRecord attributes}
  spec.summary       = %q{Enumerated types for ActiveRecord attributes}
  spec.homepage      = "https://github.com/foraker/active_record_enumerated_type"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "i18n"
  spec.add_dependency "enumerated_type"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
