class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps

  key :start_time, :type => Date
  key :end_time, :type => Date
  key :canceled_at, :type => Date

  key :project_id

  referenced_in :project
  referenced_in :sprint
  referenced_in :meeting_type

  validates_presence_of :start_time, :end_time

#  belongs_to :project
#  belongs_to :sprint
#  belongs_to :meeting_type
#
#  before_create :set_created_by
#
#
#
#  def set_created_by
#    self.created_by = UserSession.current_user.login
#  end
end