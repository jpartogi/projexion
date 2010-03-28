class User < ActiveRecord::Base
  acts_as_authentic

  has_many :project_members
  has_many :projects, :through => :project_members
  has_many :tasks

  validates_uniqueness_of :login, :email
end
