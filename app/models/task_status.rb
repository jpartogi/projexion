class TaskStatus < ActiveRecord::Base
  has_many :tasks

  #TODO: By default, on save the position is the next largest
end