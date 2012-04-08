
# This code will be run each time you run your specs.
ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'faker'
require 'factory_girl_rails'
require 'database_cleaner'


DatabaseCleaner.strategy = :truncation
#DatabaseCleaner.clean
#FactoryGirl.find_definitions

class ActiveSupport::TestCase
  
  self.use_transactional_fixtures = true
  
  def teardown
    DatabaseCleaner.clean    
  end
  
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  
  self.use_transactional_fixtures = true
  
  #FactoryGirl.reload
  
  def teardown
    DatabaseCleaner.clean
    Capybara.reset_sessions! 
    Capybara.use_default_driver 
  end 
end  

