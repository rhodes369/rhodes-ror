
# This code will be run each time you run your specs.
ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'faker'
require 'factory_girl_rails'
require 'database_cleaner'

#FactoryGirl.find_definitions
DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all
  self.use_transactional_fixtures = true
  DatabaseCleaner.clean
  FactoryGirl.reload
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  
  self.use_transactional_fixtures = true

  def teardown
    DatabaseCleaner.clean
    Capybara.reset_sessions! 
    Capybara.use_default_driver 
  end 
end  

# FactoryGirl.reload
