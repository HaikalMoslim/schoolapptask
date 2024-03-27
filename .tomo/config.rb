plugin "git"
plugin "env"
plugin "bundler"
plugin "rails"
plugin "nodenv"
plugin "puma"
plugin "rbenv"
plugin "./plugins/demo1.rb"

host "haikal@152.42.178.64"

set application: "demo1"
set deploy_to: "/home/haikal/%{application}"
set rbenv_ruby_version: "3.3.0"
set nodenv_node_version: "20.11.0"
set nodenv_install_yarn: true
set git_url: "https://github.com/HaikalMoslim/schoolapptask.git"
set git_branch: "main"
set git_exclusions: %w[
  .tomo/
  spec/
  test/
]
set env_vars: {
  RACK_ENV: "production",
  RAILS_ENV: "production",
  RAILS_LOG_TO_STDOUT: "1",
  RAILS_SERVE_STATIC_FILES: "1",
  RUBY_YJIT_ENABLE: "1",
  BOOTSNAP_CACHE_DIR: "tmp/bootsnap-cache",
  DATABASE_URL: :prompt,
  SECRET_KEY_BASE: :prompt
}
set linked_dirs: %w[
  .yarn/cache
  log
  node_modules
  public/assets
  public/packs
  public/vite
  tmp/cache
  tmp/pids
  tmp/sockets
]

set linked_files: %w[
  config/database.yml
]

setup do
  run "env:setup"
  run "core:setup_directories"
  run "git:config"
  run "git:clone"
  run "git:create_release"
  run "core:symlink_shared"
  run "nodenv:install"
  run "rbenv:install"
  run "bundler:upgrade_bundler"
  run "bundler:config"
  run "bundler:install"
  # run "rails:db_create"
  # run "rails:db_schema_load"
  # run "rails:db_seed"
  run "puma:setup_systemd"
end

deploy do
  run "env:update"
  run "git:create_release"
  run "core:symlink_shared"
  run "core:write_release_json"
  run "bundler:install"
  # run "bundle:install"
  run "rails:db_create"
  run "rails:db_migrate"
  run "rails:db_seed"
  run "rails:assets_precompile"
  run "core:symlink_current"
  run "puma:restart"
  run "puma:check_active"
  run "core:clean_releases"
  run "bundler:clean"
  run "core:log_revision"
end
