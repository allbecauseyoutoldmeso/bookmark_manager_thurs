require 'data_mapper'
require './app/app.rb'

namespace :db do

  desc "Non destructive upgrade"
  task :auto_upgrade do   
    DataMapper.auto_upgrade!
    puts 'DataMapper auto_upgrade has been run! (No data loss.)'
  end

  desc 'Destructive upgrade'
  task :auto_migrate do
    DataMapper.auto_migrate!
    puts 'DataMapper auto_migrate has been run! (Data was lost.)'
  end

end
