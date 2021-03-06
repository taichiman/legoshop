#OPTIMIZE improve speed of deploing
#TODO make elegant exit unicorn restart and stop

set :application, 'legoshop'
set :user, 'www'
set :scm, :git
set :repo_url, 'git@github.com:taichiman/legoshop.git'
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

set :rvm_type, :system
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
    # on roles(:app) do
      invoke 'deploy:unicorn:restart'
    # end
  end

  namespace :unicorn do
    
    pid_path = "#{fetch :release_path}/tmp/pids"
    unicorn_pid = "#{pid_path}/unicorn.pid"

    desc 'Start unicorn'
    task :start do
      on roles(:app) do
        within current_path do
          with rails_env: fetch(:rails_env) do
            execute :bundle, "exec #{fetch(:unicorn_binary)} -c #{fetch :unicorn_conf} -E #{fetch :rails_env} -D"
          end
        end
      end
    end

    desc 'Stop unicorn'
    task :stop do
      on roles(:app) do
        execute "if [ -f #{fetch :unicorn_pid} ] && [ -e /proc/$(cat #{fetch :unicorn_pid}) ]; then kill `cat #{fetch :unicorn_pid}`; fi"
      end
    end

    desc 'Restart unicorn'
    task :restart do
      on roles(:app) do
        on roles(:app) do
          execute "if [ -f #{fetch :unicorn_pid} ] && [ -e /proc/$(cat #{fetch :unicorn_pid}) ]; then kill `cat #{fetch :unicorn_pid}`; fi"
        end

        on roles(:app) do
          within current_path do
            with rails_env: fetch(:rails_env) do
              execute :bundle, "exec #{fetch(:unicorn_binary)} -c #{fetch :unicorn_conf} -E #{fetch :rails_env} -D"
            end
          end
        end
      end
    end

  end

  after :finishing, 'deploy:cleanup'

end
