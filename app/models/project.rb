class Project < ActiveRecord::Base
  validates_presence_of :name, :code
  validates_uniqueness_of :code

  has_many :project_members
  has_many :users, :through => :project_members
  has_many :features
  has_many :releases
end
