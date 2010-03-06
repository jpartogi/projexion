class User < ActiveRecord::Base
  acts_as_authentic
  #TODO: Add admin flag
  has_many :project_members
  has_many :projects, :through => :project_members
end
