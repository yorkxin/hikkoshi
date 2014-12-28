# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hikkoshi/version'

Gem::Specification.new do |spec|
  spec.name          = "hikkoshi"
  spec.version       = Hikkoshi::VERSION
  spec.authors       = ["Yu-Cheng Chuang"]
  spec.email         = ["ducksteven@gmail.com"]
  spec.summary       = %q{Blog Moving Tool Framework}
  spec.description   = %q{A frmaework to move your blog from one system to another"}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-byebug", "~> 2.0.0"
end
