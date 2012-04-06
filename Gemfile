source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'sqlite3', '1.3.5'
gem 'haml-rails'
gem 'slugged', '~> 1.0.1'
gem "paperclip", "~> 3.0"
gem 'bcrypt-ruby', '3.0.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'coffee-filter'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '>= 2.0.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
gem 'ruby-debug19' #, :require => 'ruby-debug' # the require breaks on my local -drJ


group :development, :test do
  gem 'growl', '1.0.3'
  #gem 'test-unit', '2.4.8'
  # gem 'ruby-prof'
  # gem 'guard-spork'  
  # gem 'spork', '~> 1.0rc'
  # gem 'spork-testunit'
  # gem 'rb-fsevent', '0.4.3.1', :require => false
  # gem 'guard-test', '0.4.3'
  gem 'faker', '1.0.1'
  #gem 'factory_girl_rails', '~> 1.4.0' # old school
  # using factory_girl master for now since it has a depreciation warning patch
  gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => "master"
  gem 'factory_girl_rails', :git => 'git://github.com/thoughtbot/factory_girl_rails.git', :branch => "master", :require => false
  
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'shoulda', '3.0.1'
  gem 'mocha', '0.10.5'
  gem 'turn', '0.9.4'
  gem 'minitest'
  gem 'database_cleaner'
end