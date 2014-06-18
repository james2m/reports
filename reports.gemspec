# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "reports/version"

Gem::Specification.new do |s|
  s.name        = "reports"
  s.version     = Reports::VERSION
  s.date        = `git log -1 --format="%cd" --date=short lib/reports/version.rb`
  s.authors     = ["James McCarthy"]
  s.email       = ["james2mccarthy@gmail.com"]
  s.homepage    = "https://github.com/james2m/reports"
  s.summary     = %q{Adds simple extensible reporting to a Rails application.}
  s.description = %q{Adds simple extensible reporting to a Rails application.}

  s.rubyforge_project = "reports"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest", "> 4"
  s.add_development_dependency "rails", "> 4"
end
