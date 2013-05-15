set_default(:config_files) { [] }

namespace :config do
  task :symlink, roles: :app do
    config_files.each do |file|
      run "ln -nfs #{shared_path}/config/#{file} #{release_path}/config/#{file}"
    end
  end
  after "deploy:finalize_update", "config:symlink"

  task :symlink_secret, roles: :app do
    run "ln -nfs #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
  after "config:symlink", "config:symlink_secret"
end
