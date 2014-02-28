# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "the_castle_client/version"

Gem::Specification.new do |s|
  s.name        = "the_castle_client"
  s.version     = TheCastleClient::VERSION
  s.authors     = ["Andrew Kuklewicz"]
  s.email       = ["andrew@prx.org"]
  s.description = %q{Client to connect via 2-legged oauth, and get data from the castle.}
  s.summary     = %q{Get data from the castle, the PRX data warehouse.}
  s.homepage    = "https://github.com/PRX/TheCastle"
  s.license     = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency('bundler')
  s.add_development_dependency('rake')
  # s.add_development_dependency('webmock')

  s.add_runtime_dependency("activesupport")
  s.add_runtime_dependency("oauth")
  s.add_runtime_dependency("json")

end
