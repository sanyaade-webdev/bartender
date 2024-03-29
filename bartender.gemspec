Gem::Specification.new do |s|
  s.name        = "bartender"
  s.version     = "0.6.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tristan Dunn"]
  s.email       = "hello@tristandunn.com"
  s.homepage    = "http://openbeerdatabase.com"
  s.summary     = "A Ruby client for Open Beer Database."
  s.description = "A Ruby client for Open Beer Database."

  s.files        = Dir["lib/**/*"].to_a
  s.test_files   = Dir["spec/**/*"].to_a
  s.require_path = "lib"

  s.add_dependency "multi_json", "1.4.0"

  s.add_development_dependency "bourne",  "1.3.0"
  s.add_development_dependency "rake",    "10.0.2"
  s.add_development_dependency "rspec",   "2.12.0"
  s.add_development_dependency "yard",    "0.8.3"
end
