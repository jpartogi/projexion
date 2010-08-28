class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_time, :type => Time
  field :end_time, :type => Time
  field :canceled_at, :type => Time
  field :location
  field :additionals

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