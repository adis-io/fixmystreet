require "bundler/capistrano"

set :application, "fixmystreet"
set :repository,  "git://github.com/kalys/fixmystreet.git"

set :scm, :git
set :branch, "develop"

server "fixmystreet.kg", :app, :web, :db, :primary => true

set :deploy_to, "/home/rsskg/fixmystreet.kg"

set :user, "rsskg"
set :group, "users"
set :use_sudo, false
set :default_environment, {
  'PATH' => "/usr/local/rvm/gems/ruby-1.9.2-p290/bin:/usr/local/rvm/bin:/usr/local/rvm/gems/ruby-1.9.2-p290/bin:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.2-p290',
  'GEM_HOME'     => '/usr/local/rvm/gems/ruby-1.9.2-p290',
  'GEM_PATH'     => '/usr/local/rvm/gems/ruby-1.9.2-p290',
  'BUNDLE_PATH'  => '/usr/local/rvm/gems/ruby-1.9.2-p290'  # If you are using bundler.
}


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
    run "cp -R #{shared_path}/config/* #{current_release}/config/"
  end

  after "deploy:finalize_update", "deploy:update_configs"
end
