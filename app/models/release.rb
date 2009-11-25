class Release < ActiveRecord::Base
  belongs_to :project
  has_many :features
  #TODO: Add released (boolean) property whether a release has been released
  validates_presence_of :version_number
end
