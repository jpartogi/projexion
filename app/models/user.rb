class User < ActiveRecord::Base
  has_many :project_members
  has_many :projects, :through => :project_members
end
