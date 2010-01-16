class Project < ActiveRecord::Base
  validates_presence_of :name, :vision
  #validates_uniqueness_of :code #TODO Manually validates uniqueness and presence of code :-(

  has_many :project_members
  has_many :users, :through => :project_members
  has_many :features, :primary_key => :code, :foreign_key => :project_code
  has_many :releases, :primary_key => :code, :foreign_key => :project_code
  has_many :sprints, :primary_key => :code, :foreign_key => :project_code
end
