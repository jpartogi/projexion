class Meeting < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :meeting_type
end