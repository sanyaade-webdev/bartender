Gem::Specification.new do |s|
  s.name        = "bartender"
  s.version     = "0.1.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = []
  s.email       = []
  s.homepage    = "http://openbeerdatabase.com"
  s.summary     = "A Ruby client for Open Beer Database."
  s.description = "A Ruby client for Open Beer Database."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "bartender"

  s.add_dependency "yajl-ruby", ">= 0.8.2"

  s.add_development_dependency "bluecloth", ">= 2.1.0"
  s.add_development_dependency "bourne",    ">= 1.0.0"
  s.add_development_dependency "bundler",   ">= 1.0.13"
  s.add_development_dependency "mocha",     ">= 0.9.8"
  s.add_development_dependency "rspec",     ">= 2.6.0"
  s.add_development_dependency "yard",      ">= 0.6.8"

  s.files        = `git ls-files`.split("\n")
  s.require_path = "lib"
end
