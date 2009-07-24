set :application, "helpdesk"
set :domain, "www.nsnmwcaretelcel.com"

##
# Settings
##
#load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
set :deploy_to, "/var/rails/#{application}"
default_run_options[:pty] = true
set :use_sudo, true
set :user, "deployer"
set :runner, "www-data"

##
# Git
##
set :repository, "git@github.com:alexjr85/helpdesk.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

##
# Servers
##
role :web, domain
role :app, domain

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
  end
end