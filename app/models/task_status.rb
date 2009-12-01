class TaskStatus < ActiveRecord::Base
  has_many :tasks
end