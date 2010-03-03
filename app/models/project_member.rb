class ProjectMember < ActiveRecord::Base
  # project_role scrum master, team_member, product owner
  
  belongs_to :user
  belongs_to :project
  belongs_to :project_role
end