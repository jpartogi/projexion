class Sprint < ActiveRecord::Base
  has_many :backlogs

  validates_presence_of :start_date, :end_date
end
