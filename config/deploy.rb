set :application, "helpdesk"
set :domain, "www.nsnmwcaretelcel.com"

##
# Settings
##
#load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
set :deploy_to, "/var/rails/#{application}"
set :doc_dir, "/var/rails/#{application}_doc"
default_run_options[:pty] = true
set :use_sudo, true
set :user, "deployer"

##
# Git
##
set :repository, "git@github.com:alecz/helpdesk.git"
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
  task :after_update_code, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/system/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{doc_dir} #{release_path}/public/documentation"
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
    run "ruby #{current_path}/script/runner #{current_path}/tools/mail_sender.rb stop"
    run "ruby #{current_path}/script/runner #{current_path}/tools/mail_sender.rb start"
  end
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{current_path} && whenever --update-crontab #{application}"
  end

  [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
  end
end

namespace :migrate do
  desc "Reset the DB by dropping it and running migrations"
  task :reset, :roles => :app do
    run "cd #{current_path} && #{sudo} rake db:migrate:reset"
  end  
end
