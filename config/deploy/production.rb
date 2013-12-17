set :deploy_to, -> { "/home/#{fetch :user}/#{fetch :application}/#{fetch(:stage)}" }
set :stage, :production
set :branch, :master

# fetch(:default_env).merge!(rails_env: :production)
