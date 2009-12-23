class TaskHistory < ActiveRecord::Base
  belongs_to :task
  belongs_to :task_status
end