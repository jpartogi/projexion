class Feature < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  has_many :tasks
  #TODO: Add accepted (boolean) property to identify whether feature has been accepted by product owner
  validates_presence_of :user_story, :acceptance_test
end