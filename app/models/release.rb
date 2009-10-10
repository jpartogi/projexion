class Release < ActiveRecord::Base
  belongs_to :project
  has_many :backlogs
end
