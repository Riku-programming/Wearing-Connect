# config valid for current version and patch releases of Capistrano
lock "~> 3"

set :application, "Wearing-Connect"
set :repo_url, "git@github.com:Riku-programming/Wearing-Connect.git"
# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, "master"

# deploy先のディレクトリ。
set :deploy_to, "/var/www/rails/Wearing-Connect"

# シンボリックリンクをはるファイル
set :linked_files, fetch(:linked_files, []).push("config/master.key")
# append :linked_files, 'config/credentials/production.key'

# シンボリックリンクをはるフォルダ
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")
# set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }


# 保持するバージョンの個数(※後述)
set :keep_releases, 5

set :bundle_gemfile, "/var/www/rails/Wearing-Connect/Gemfile"


# rubyのバージョン
set :rbenv_ruby, "2.6.5"

# 出力するログのレベル。
set :log_level, :debug

namespace :deploy do
  desc "Restart application"
  task :restart do
    invoke "unicorn:restart"
  end

  desc "Create database"
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, "db:create"
        end
      end
    end
  end

  desc "Run seed"
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, "db:seed"
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  desc 'upload master.key'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end
