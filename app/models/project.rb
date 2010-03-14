class Project < ActiveRecord::Base
  validates_presence_of :name, :vision
  validates_uniqueness_of :code

  has_many :project_members
  has_many :users, :through => :project_members
  has_many :features
  has_many :releases
  has_many :sprints

  def active_sprints
    self.sprints.where(['end_date > ? and cancelled_at is null', Date.today])
  end

  def current_sprint
    self.sprints.where(['start_date <= ? and end_date > ?', Date.today, Date.today])
  end

  def active_releases
    self.releases.where(['released_at is null'])
  end

  def manager
    self.project_members.each do |project_member|
      if project_member.project_role.eql? ProjectRole.manager
        return project_member.user
      end
    end

    nil
  end

  def members
    self.project_members.reject do |project_member|
      project_member.project_role.eql? ProjectRole.manager
    end
  end
end
