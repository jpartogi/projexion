class ProjectRole < ActiveRecord::Base
  belongs_to :project_member

  before_save :check_and_update_manager

  def check_and_update_manager
    manager = ProjectRole.manager

    unless manager.nil?
      if self.manager
        manager.manager = false
        manager.save
      end
    end
  end
  
  class << self
    def manager
      ProjectRole.first(:conditions => {:manager => true})
    end
  end
end