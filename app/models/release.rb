class Release < ActiveRecord::Base
  belongs_to :project
  has_many :backlogs

  validates_presence_of :version_number
end
