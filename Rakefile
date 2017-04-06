require 'data_mapper'
require './app/app.rb'

namespace :db do

  desc "Non destructive upgrade"
  task :auto_upgrade do
    DataMapper.auto_upgrade!
    puts 'DataMapper auto_upgrade has been run! (No data loss.)'
  end
  #run using: rake db:auto_upgrade +/- RACK_ENV=test
  # default environment is development
  # or heroku run rake db:auto_upgrade
  # default environment is production

  desc 'Destructive upgrade'
  task :auto_migrate do
    DataMapper.auto_migrate!
    puts 'DataMapper auto_migrate has been run! (Data was lost.)'
  end

end
