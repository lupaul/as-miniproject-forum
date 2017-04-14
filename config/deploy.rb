# config valid only for current version of Capistrano
lock "3.8.0"

`ssh-add` # 注意這是鍵盤左上角的「 `」不是單引號「 '」


set :application, 'alphastudy'

set :repo_url, "git@github.com:lupaul/as-miniproject-forum.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/pochia/as-miniproject-forum"



set :keep_releases, 5

append :linked_files, 'config/database.yml', 'config/secrets.yml'
# 如果有 facebook.yml 或 email.yml 想要連結的話，也要加進來

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :passenger_restart_with_touch, true

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# git clone 完成後會從 shared 資料夾 copy 過去的檔案
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# git clone 完成後會從 shared 資料夾 copy 過去的資料夾
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
