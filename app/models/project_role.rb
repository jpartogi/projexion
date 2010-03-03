class ProjectRole < ActiveRecord::Base
  belongs_to :project_member
end