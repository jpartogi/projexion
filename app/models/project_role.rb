class ProjectRole
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :role

  references_many :project_member
  referenced_in :account
 
  validates_presence_of :name

end