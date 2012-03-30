ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
# require 'database_cleaner'
# DatabaseCleaner.strategy = :truncation


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL  
  
  # DatabaseCleaner.start
  
  def teardown 
    Capybara.reset_sessions! 
    Capybara.use_default_driver 
    
    #DatabaseCleaner.clean 
  end 
end
