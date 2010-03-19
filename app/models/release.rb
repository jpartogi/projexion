class Release < ActiveRecord::Base
  belongs_to :project
  has_many :features
  has_many :sprints
  
  validates_presence_of :version_number
  #TODO: Create release notes on released
end
