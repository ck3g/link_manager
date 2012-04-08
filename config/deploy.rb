require 'capistrano_colors'
require 'bundler/capistrano'
require 'rvm/capistrano'

server "78.47.60.11", :web, :app, :db, :primary => true

set :application, "link_manager"
set :user, "deploy"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :export
set :use_sudo, false

set :rvm_ruby_string, "1.9.3@#{application}"

set :scm, :git
set :repository,  "git@github.com:ck3g/link_manager.git"
set :branch, "deploy_to_vps"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, :roles => :app, :except => {:no_release => true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, :roles => :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.example"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}"
  end

  after "deploy:setup", "deploy:setup_config"
  after "deploy:finalize_update", "deploy:symlink_config"

  before "deploy:cold", "deploy:install_bundler"
  task :install_bundler, :roles => :app do
    run "type -P bundle &>/dev/null || { gem install bundler --no-ri --no-rdoc; }"
  end

end

