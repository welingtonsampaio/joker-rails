# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'joker/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "joker-rails"
  spec.version       = Joker::Rails::VERSION
  spec.authors       = ["Welington Sampaio"]
  spec.email         = ["welington.sampaio@zaez.net"]
  spec.description   = %q{Bla}
  spec.summary       = %q{Bla 2}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "jquery-rails"
  spec.add_dependency 'mustache'
  spec.add_dependency 'pundit'
  spec.add_dependency 'devise'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
