class Project < ActiveRecord::Base
  validates_presence_of :name, :vision
  #validates_uniqueness_of :code #TODO Manually validates uniqueness and presence of code :-(

  has_many :project_members
  has_many :users, :through => :project_members
  has_many :features
  has_many :releases
  has_many :sprints

  def active_sprints
    self.sprints.reject do |sprint|
      Date.today > sprint.end_date or not sprint.cancelled_at.nil?
    end
  end

  def active_releases
    self.releases.reject do |release|
      not release.released_at.nil?
    end
  end

  def manager
    self.project_members.each do |project_member|
      if project_member.project_role.eql? ProjectRole.manager
        return project_member.user
      end
    end
  end
end
