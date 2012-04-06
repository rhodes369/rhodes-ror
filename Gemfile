source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'sqlite3', '1.3.5'
gem 'slugged', '~> 1.0.1'
gem "paperclip", "~> 3.0"
gem 'coffee-filter'
gem 'haml-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '>= 2.0.1'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
gem 'ruby-debug19' #, :require => 'ruby-debug' # the require breaks on my local -drJ

group :development, :test do
  gem 'growl', '~> 1.0.3'
  gem 'guard-test', '0.4.3'
  gem 'guard-spork', '~> 0.5.2'
  gem 'spork-testunit'
  gem 'faker', '~> 1.0.1'
  gem 'factory_girl_rails', '~> 3.0'
end

group :test do
  gem 'capybara', '~> 1.1.2'
  gem 'shoulda', '~> 3.0.1'
  gem 'mocha', '~> 0.10.5'
  gem 'turn', '~> 0.9.4'
  gem 'database_cleaner', '~> 0.7.2'
  gem 'minitest', '~> 2.11.4', :require => false # for turn
  gem 'rb-fsevent', '~> 0.4.3.1', :require => false
  gem 'ruby-prof', :require => false
end