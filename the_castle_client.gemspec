# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "the_castle_client/version"

Gem::Specification.new do |s|
  s.name        = "the_castle_client"
  s.version     = TheCastleClient::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["kookster"]
  s.email       = ["andrew@prx.org"]
  s.homepage    = ""
  s.summary     = %q{Get data from the castle, the PRX data warehouse.}
  s.description = %q{Client to connect via 2-legged oauth, and get data from the castle.}

  s.rubyforge_project = "the_castle_client"

  s.add_dependency("activesupport")
  s.add_dependency("oauth")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
