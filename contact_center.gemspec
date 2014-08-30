$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "contact_center/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "contact_center"
  s.version     = ContactCenter::VERSION
  s.authors     = ["Mathieu Lajugie"]
  s.email       = ["mathieu@caring.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ContactCenter."
  s.description = "TODO: Description of ContactCenter."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0.beta1"
  s.add_dependency "twilio-ruby", "~> 3.12.2"
  s.add_dependency "state_machine", "~> 1.2.0"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
