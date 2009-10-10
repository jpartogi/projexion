class Project < ActiveRecord::Base
  has_many :project_members
  has_many :users, :through => :project_members
  has_many :backlogs
  has_many :releases
end
