require "bundler/capistrano"
require "rvm/capistrano"

set :application, "iconizer"
set :repository,  "git@github.com:IvanShamatov/iconizer.git"
set :scm, :git
default_run_options[:pty] = true

set :user, "deploy"
role :web, "ikonkin.ru"                          # Your HTTP server, Apache/etc
role :app, "ikonkin.ru"                          # This may be the same as your `Web` server


set :rvm_ruby_string, "ruby-2.0.0-p247"
set :rvm_type, :user

set :deploy_to, "/home/deploy/ikonkin"

namespace :deploy do
 
  task :restart do
    run "cd #{current_path} && bundle exec thin restart -C config/thin.yml"
  end
 
  task :start do
    run "cd #{current_path} && bundle exec thin start -C config/thin.yml"
  end
 
  task :stop do
    run "cd #{current_path} && bundle exec thin stop -C config/thin.yml"
  end
 
end