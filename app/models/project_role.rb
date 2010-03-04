class ProjectRole < ActiveRecord::Base
  belongs_to :project_member

  class << self
    def manager
      ProjectRole.first(:conditions => {:manager => true})
    end
  end
end