source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'sqlite3', '1.3.6'
gem 'slugged', '~> 1.0'
gem "paperclip", '~> 3.0'
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


# for ruby-1.9.2-p180 debugger
#gem 'ruby-debug-base19', "0.11.25"
#gem 'ruby-debug19', "0.11.6"

gem 'linecache19', '0.5.12'
gem 'ruby-debug-base19', '0.11.25'
gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'growl', '~> 1.0'
  gem 'guard-test'
  gem 'guard-spork'
  gem 'spork-testunit'
  gem 'faker', '~> 1.0'
  gem 'factory_girl_rails', '~> 3.1'
end

group :test do
  gem 'capybara', '~> 1.1'
  gem 'shoulda', '~> 3.0'
  gem 'mocha'
  gem 'turn', '~> 0.9'
  gem 'minitest', '~> 2.1', :require => false # for turn
  gem 'rb-fsevent', :require => false
  gem 'ruby-prof', :require => false
end