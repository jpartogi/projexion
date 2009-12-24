namespace :projexion do

  namespace :tasks do
    task :daily => :environment do
      require File.expand_path('../../../config/application',  __FILE__)

      TaskDaily.sum_daily_tasks
      
    end
  end

end