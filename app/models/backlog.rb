class Backlog < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  has_many :tasks
end
