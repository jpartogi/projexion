class TaskStatus < ActiveRecord::Base
  has_many :tasks

  before_create :set_next_position
  
  def set_next_position
    last_status = TaskStatus.find(:last, :order => "position")
    self.position = last_status.position + 1
  end

  def update_position(direction)
    position = self.position

    if direction == 'up'
      status = TaskStatus.find_by_position(position.to_i - 1)
    else
      status = TaskStatus.find_by_position(position.to_i + 1)
    end

    self.position = status.position
    status.position = position

    self.save
    status.save

    return self
  end
end