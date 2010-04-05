class ProjectMember < ActiveRecord::Base  
  belongs_to :user
  belongs_to :project
  belongs_to :project_role

  validate :only_one_manager_per_project

  def only_one_manager_per_project
    if self.project_role == ProjectRole.manager
      manager = ProjectMember.first(:conditions => {:project_id => self.project, :project_role_id => self.project_role})
      errors.add(:manager, "role for #{self.project.name} already exists") unless manager.nil?
    end
  end
end