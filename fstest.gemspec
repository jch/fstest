# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fstest/version"

Gem::Specification.new do |s|
  s.name        = "fstest"
  s.version     = FSTest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jerry Cheung"]
  s.email       = ["jch@whatcodecraves.com"]
  s.homepage    = "http://whatcodecraves.com"
  s.summary     = %q{Extracted file and directory assertion methods from Rails::Generators::TestCase.}
  s.description = %q{Include the FSTest module for testing file existence, and file contents.}

  s.add_development_dependency "minitest"
  s.add_development_dependency "fakefs"

  s.rubyforge_project = "fstest"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
