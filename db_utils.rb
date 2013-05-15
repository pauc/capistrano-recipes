namespace :db do
  desc "Rebuilds the production database and runs all the migrations"
  task :redo, :roles => :db do
    run "cd #{current_path}; bundle exec rake db:drop RAILS_ENV=#{rails_env}"
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  end
  before "db:redo", "deploy:stop"
  after "db:redo", "deploy:migrate", "db:seed", "deploy:start"

  desc "Loads the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end