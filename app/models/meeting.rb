class Meeting < ActiveRecord::Base
  belongs_to :project, :primary_key => :code, :foreign_key => :project_code
  belongs_to :sprint
  belongs_to :meeting_type
end