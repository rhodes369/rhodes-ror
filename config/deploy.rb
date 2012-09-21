require "bundler/capistrano"
load "deploy/assets"

set :stages, %w(production staging)
set :default_stage, "staging"
require "capistrano/ext/multistage"

set :repository,  "git@github.com:rhodes369/rhodes-ror.git"
set :scm, :git
set :deploy_via, :remote_cache

set :use_sudo, false
set :keep_releases, 5
set :user, "rhodes"

set :application, "rhodes"
server "96.44.174.157", :web, :app, :db, :primary => true, :memcached => true


ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# default_environment["RAILS_ENV"] = 'production'

after "bundle:install", "deploy:set_configs"
after "deploy:update_code", "deploy:build_missing_paperclip_styles"
after "deploy:finalize_update", "deploy:cleanup"

namespace :deploy do 
  
  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake paperclip:refresh:missing_styles"
  end

  desc "set up extra configs"
  task :set_configs, :role => :app do
    run "ln -sf #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  task :start do
    run "#{sudo} service #{unicorn_service} start"
  end
  task :stop do
    run "#{sudo} service #{unicorn_service} stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{sudo} service #{unicorn_service} restart"
  end
end
