ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("dummy/config/environment", __dir__)
require 'rspec/rails'

Dir[File.expand_path("support/**/*.rb", __dir__)].each do |name| require name end

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
