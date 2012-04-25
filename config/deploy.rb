require "bundler/capistrano"
load "deploy/assets"

set :application, "staging.rhodes.org"
set :repository,  "git@github.com:rhodes369/rhodes-ror.git"
set :scm, :git
set :deploy_via, :remote_cache

set :rails_env, "production"
set :branch, "master"

set :use_sudo, false
set :keep_releases, 5
set :user, "rhodes"

# role :web, "50.57.155.246"                          # Your HTTP server, Apache/etc
# role :app, "50.57.155.246"                          # This may be the same as your `Web` server
# role :db,  "50.57.155.246", :primary => true # This is where Rails migrations will run
server "50.57.155.246", :web, :app, :db, :primary => true, :memcached => true

set :deploy_to, "/home/rhodes/#{application}"

ssh_options[:forward_agent] = true
default_run_options[:shell] = 'bash'
default_run_options[:pty] = true

default_environment["RAILS_ENV"] = 'production'

after "bundle:install", "deploy:set_configs"
after "deploy:set_configs", "deploy:migrate"
after "deploy:update_code", "deploy:build_missing_paperclip_styles"
after "deploy:finalize_update", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do 
  
  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake paperclip:refresh:missing_styles"
  end

  desc "set up extra configs"
  task :set_configs, :role => :app do
    run "ln -sf ~/config/database.yml #{latest_release}/config/database.yml"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
