$:.push File.expand_path("../lib", __FILE__)

require "model_observer/version"

Gem::Specification.new do |s|
  s.name        = "model_observer"
  s.version     = ModelObserver::VERSION
  s.authors     = ["Weihu Chen"]
  s.email       = ["cctiger36@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Help to find out duplicated orm object creation."
  s.description = "Help to find out duplicated orm object creation."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
