class ProjectRole < ActiveRecord::Base
  belongs_to :project_member
  #TODO: Make sure there is only one manager
  class << self
    def manager
      ProjectRole.first(:conditions => {:manager => true})
    end
  end
end