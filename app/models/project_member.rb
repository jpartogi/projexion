class ProjectMember < ActiveRecord::Base  
  belongs_to :user
  belongs_to :project
  belongs_to :project_role

  validate :only_one_manager_per_project

  def only_one_manager_per_project
    manager = ProjectMember.first(:conditions => {:project_id => self.project, :project_role_id => ProjectRole.manager})
    errors.add(:manager, "role for #{self.project.name} already exists") unless manager.nil?
  end
end