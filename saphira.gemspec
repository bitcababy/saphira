$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "saphira/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "saphira"
  s.version     = Saphira::VERSION
  s.authors     = ["Paul Spieker"]
  s.email       = ["p.spieker@duenos.de"]
  s.homepage    = ""
  s.summary     = "A simple file manager created for RoR using mountable engines."
  s.description = "This is a simple file manager created in RoR as a mountable engine. It's created for Railsyard CMS but will also work without it. To use it in RY use ry-filemanager gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1", "< 7.0"
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'dragonfly'
  s.add_dependency 'exifr'
  s.add_dependency "friendly_id", "~> 4.0.0.beta8"
  s.add_dependency 'acts-as-taggable-on', '~>2.1.0'
  s.add_dependency 'sass'
  s.add_dependency 'coffee-script'
  s.add_dependency 'uglifier'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'mini_magick'
  
  s.add_development_dependency 'cucumber', '>= 0.10.2'
  s.add_development_dependency 'cucumber-rails', '>= 0.4.1'
  s.add_development_dependency 'webrat', '>= 0.7.3'
  s.add_development_dependency 'capybara', '>= 1.0.0'
  s.add_development_dependency 'deadweight', '>=0.2.1'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'growl_notify'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'railroady'
  s.add_development_dependency 'pry'
  s.add_development_dependency "sqlite3"
end
