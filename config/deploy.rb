require "bundler/capistrano"
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.

set :rvm_ruby_string, '1.9.2'        # Or whatever env you want it to run in.
set :using_rvm, true
set :application, "fixmystreet"
set :repository,  "git://github.com/kalys/fixmystreet.git"

set :scm, :git
set :branch, "kg"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "fixmystreet.kg", :app, :web, :db, :primary => true

set :deploy_to, "/home/rsskg/fixmystreet.kg"

set :user, "rsskg"
set :group, "rsskg"
set :use_sudo, false

namespace :deploy do
  task :start do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Update devise auth credentials (Twitter, Facebook)"
  task :update_configs do
    run "cp #{shared_path}/config/social.yml #{current_release}/config/"
    run "cp #{shared_path}/config/database.yml #{current_release}/config/"
  end

  after "deploy:finalize_update", "deploy:update_configs"
end
