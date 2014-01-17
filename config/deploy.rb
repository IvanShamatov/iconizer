require "bundler/capistrano"
# require 'capistrano/rvm'

set :application, "iconizer"
set :repository,  "git@github.com:IvanShamatov/iconizer.git"
set :scm, :git
default_run_options[:pty] = true

set :user, "deploy"
role :web, "ikonkin.ru"                         
role :app, "ikonkin.ru"                    


set :rvm_ruby_string, "ruby-2.0.0-p247"
set :rvm_type, :user
set :use_sudo, :false


set :deploy_to, "/home/deploy/ikonkin"

namespace :thin do
 
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