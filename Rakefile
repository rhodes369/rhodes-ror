#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

RhodesRor::Application.load_tasks

@rake_logger = Rails.logger = Logger.new("log/rake.log")

# Swiped from Duke
def log(msg, level=:info)
  puts msg
  @rake_logger.send(level,msg)
end
