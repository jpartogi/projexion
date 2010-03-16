namespace :projexion do
  require File.expand_path('../../../config/application',  __FILE__)

  namespace :sprints do
    task :snapshot => :environment do
      
      SprintSnapshot.job
    end
  end

  namespace :releases do
    task :snapshot => :environment do
      ReleaseSnapshot.job  
    end
  end

end