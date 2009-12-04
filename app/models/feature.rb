class Feature < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  has_many :tasks
  #TODO: Extract acceptance_test into its own model
  validates_presence_of :user_story, :acceptance_test
end