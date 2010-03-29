class ProjectMember < ActiveRecord::Base  
  belongs_to :user
  belongs_to :project
  belongs_to :project_role

  #TODO: Make sure there is only one project manager per project
end