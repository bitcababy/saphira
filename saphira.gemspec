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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
