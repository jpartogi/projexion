class Release
  include Mongoid::Document
  include Mongoid::Timestamps

  field :version_number
  field :estimate_date, :type => Date
  field :goal
  field :cancelled_at, :type => Date
  field :released_at, :type => Date  

  referenced_in :project
  references_many :features
  references_many  :sprints
#  belongs_to :project
#  has_many :features
#  has_many :sprints
  
  validates_presence_of :version_number
end
