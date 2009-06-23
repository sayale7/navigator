set :application, "navigator"
set :deploy_to, "/var/rails/#{application}"
#############################################################
# Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true

#############################################################
# Servers
#############################################################

set :user, "root"
set :domain, "92.51.146.57"
server domain, :app, :web
role :db, domain, :primary => true
set :runner, "root"

#############################################################
# GIT
#############################################################

set :repository,  "git@github.com:sayale7/navigator.git"
set :scm, "git"
set :scm_passphrase, "aplhma6" #This is your custom github user password
ssh_options[:forward_agent] = true
set :branch, "master"

#############################################################
# Passenger
#############################################################

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

# [:start, :stop].each do |t|
#    desc "#{t} task is a no-op with mod_rails"
#    task t, :roles => :app do ; end
#  end
end