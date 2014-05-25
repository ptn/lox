# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lox/version'

Gem::Specification.new do |spec|
  spec.name          = "lox"
  spec.version       = Lox::VERSION
  spec.authors       = ["Pablo Torres"]
  spec.email         = ["tn.pablo@gmail.com"]
  spec.description   = %q{A toy web server}
  spec.summary       = %q{A toy web server}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    =
    spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "mocha", "~> 1.1"
  spec.add_development_dependency "rake", "~> 0.9"
end
