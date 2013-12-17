set :application, 'legoshop'
set :user, 'www'
set :scm, :git
set :repo_url, 'git@github.com:taichiman/spree_russian.git'
set :deploy_to, -> { "/home/#{ fetch :user }/#{ fetch :application }/#{ fetch :stage }" }

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :ssh_options, {:forward_agent => true}
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p247@legoshop'

set :unicorn_conf, -> { "#{fetch :deploy_to}/current/config/unicorn.rb" }
set :unicorn_pid, -> { "#{fetch :deploy_to}/shared/tmp/pids/unicorn.pid" }
set :unicorn_binary, "unicorn_rails"

role :all, %w{www@95.85.32.166}
server '95.85.32.166', user: 'www', roles: %w{web app db}

set :rake,           "rake"
set :rails_env,      "production"
set :migrate_env,    ""
set :migrate_target, :latest

# set :default_stage, "staging"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
