set_default(:config_files) { [] }

namespace :config do
  task :symlink, roles: :app do
    config_files.each do |file|
      run "ln -nfs #{shared_path}/config/#{file} #{release_path}/config/#{file}"
    end
  end
  after "deploy:finalize_update", "config:symlink"

  task :upload_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    config_files.each do |file|
      upload "config/#{file}", "#{shared_path}/config/#{file}"
    end
  end
end
