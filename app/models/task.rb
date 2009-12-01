class Task < ActiveRecord::Base
  belongs_to :feature
  belongs_to :task_status

  validates_presence_of :description
  
  before_create :set_default_status
  
  def set_default_status
    self.task_status = TaskStatus.find(:first, :conditions => {:default_status => true})
  end
end

