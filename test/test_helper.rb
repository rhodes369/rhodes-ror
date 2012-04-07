require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  # This code will be run each time you run your specs.
  ENV["RAILS_ENV"] = "test"
  
  require File.expand_path('../../config/environment', __FILE__)
  require 'rails/test_help'
  require 'capybara/rails'
  require 'shoulda'
  require 'paperclip/matchers'  
  require 'factory_girl_rails'
  require 'faker'
  require 'database_cleaner'
  
  DatabaseCleaner.strategy = :truncation
  
  class ActiveSupport::TestCase
    # Add more helper methods to be used by all tests here...
    def teardown
      DatabaseCleaner.clean
    end
  end

  class ActionDispatch::IntegrationTest
    include Capybara::DSL
    
    def teardown
      DatabaseCleaner.clean
      Capybara.reset_sessions! 
      Capybara.use_default_driver 
    end 
  end  
end

Spork.each_run do
  FactoryGirl.reload
end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.

