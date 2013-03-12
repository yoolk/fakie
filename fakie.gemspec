# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fakie/version'

Gem::Specification.new do |gem|
  gem.name          = 'fakie'
  gem.version       = Fakie::VERSION
  gem.authors       = ['Sam Soffes']
  gem.email         = ['sam@soff.es']
  gem.description   = 'libphonenumber wrapper'
  gem.summary       = 'libphonenumber wrapper with ExecJS'
  gem.homepage      = 'https://github.com/seesawco/fakie'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.8.7'
  gem.add_dependency 'execjs'
end
