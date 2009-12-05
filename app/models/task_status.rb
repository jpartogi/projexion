class TaskStatus < ActiveRecord::Base
  has_many :tasks

  before_create :set_next_position
  
  def set_next_position
    last_status = TaskStatus.find(:last, :order => "position")
    self.position = last_status.position + 1
  end
end