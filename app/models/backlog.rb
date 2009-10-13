class Backlog < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  has_many :tasks

  validates_presence_of :user_story, :accept_criteria
end
