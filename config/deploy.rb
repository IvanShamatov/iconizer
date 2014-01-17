require "bundler/capistrano"
# require 'capistrano/rvm'

set :application, "iconizer"
set :repository,  "git@github.com:IvanShamatov/iconizer.git"
set :scm, :git


set :user, "deploy"
role :web, "ikonkin.ru"               
role :app, "ikonkin.ru"                     
default_run_options[:pty] = true
default_run_options[:shell] = '/bin/bash --login'


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