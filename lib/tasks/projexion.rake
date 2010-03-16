namespace :projexion do
  require File.expand_path('../../../config/application',  __FILE__)

  namespace :tasks do
    task :daily => :environment do
      
      TaskDaily.sum_daily_tasks
    end
  end

  namespace :releases do
    task :snapshot => :environment do
      ReleaseSnapshot.job  
    end
  end

end