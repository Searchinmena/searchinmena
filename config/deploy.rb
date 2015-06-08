set :application, 'sim'
server "sim.demo.llp.pl", user: "lunar", roles: %w{web app db}, port: 20_022
set :port, 20_022
set :branch, "master"

set :repo_url, "git@github.com:LunarLogic/sim.git"
set :deploy_via, :remote_cache
set :copy_exclude, [".git"]

set :user, "lunar"
set :deploy_to, -> { "/home/#{fetch(:user)}/apps/#{fetch(:application)}" }

set :unicorn_rack_env, -> { fetch(:rails_env) }
set :unicorn_config_path, -> { File.join(release_path, "config/unicorn.rb") }
set :unicorn_pid, -> { File.join(current_path, "pids/unicorn.pid") }

set :rails_env, "production"
set :deploy_env, -> { fetch(:rails_env) }
set :honeybadger_env, -> { fetch(:stage) }
fetch(:default_env).merge!(rails_env: "production", rack_env: "production")
set :ssh_options, forward_agent: true

set :rvm_type, :system
set :rvm_ruby_version, -> { "2.2.2@#{fetch(:application)}" }
set :bundle_path, lambda {
  File.join(
    fetch(:rvm_path),
    "gems/ruby-#{fetch(:rvm_ruby_version)}"
  )
}
set :bundle_cmd, -> { File.join(fetch(:bundle_path), "bin/bundle") }

set :bundle_binstubs, -> { File.join(fetch(:bundle_path), "bin") }

set :keep_releases, 5

set :linked_files, %w{config/database.yml config/unicorn.rb}
set :linked_dirs, %w{pids log public/assets}

after "deploy:updating", "configuration:copy"
after "configuration:copy", "db:seed"
after "deploy:publishing", "unicorn:restart"
after "deploy:finishing", "deploy:cleanup"

before "deploy:compile_assets", "bower:install"
