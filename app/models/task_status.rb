class TaskStatus < ActiveRecord::Base
  has_many :tasks

  before_create :check_and_update_default_status, :set_next_position
  before_update :check_and_update_default_status
  
  def set_next_position
    last_status = TaskStatus.find(:last, :order => "position")
    self.position = last_status.position + 1
  end

  def check_and_update_default_status
    default = TaskStatus.default_status

    unless default.nil?
      if self.default_status
        # Change the current default status to make sure there's only one default status
        default.default_status = false
        default.save
      end
    end
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

    TaskStatus.transaction do
      self.save
      status.save
    end

    return self
  end
  
  # Class methods
  class << self

    def default_status
      TaskStatus.find(:first, :conditions => [ "default_status = ?", true ] )
    end

  end
end