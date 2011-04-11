class ProjectMember
  include Mongoid::Document
  include Mongoid::Timestamps

  ACTIVE = 'A'
  INACTIVE = 'I'

  field :status

  referenced_in :project_role
  referenced_in :user
  referenced_in :project

  validates_presence_of :user, :project, :project_role

end