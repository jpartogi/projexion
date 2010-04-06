class Project < ActiveRecord::Base
  validates_presence_of :name, :code, :vision
  validates_uniqueness_of :code

  has_many :project_members
  has_many :users, :through => :project_members
  has_many :features
  has_many :releases
  has_many :sprints

  def active_sprints
    self.sprints.where(['end_date > ? and cancelled_at is null', Date.today]).order("start_date")
  end

  def current_sprint
    sprint = self.sprints.where(['start_date <= ? and end_date >= ?', Date.today, Date.today])

    unless sprint.empty?
      sprint = sprint.to_a[0]
    else
      sprint = nil
    end

    sprint
  end

  def latest_sprint
    self.sprints.where(['end_date = (select max(end_date) from sprints)'])
  end

  def active_releases
    self.releases.where(['released_at is null'])
  end

  def manager
    project_member = self.project_members.where({:project_role_id => ProjectRole.manager})[0]
    project_member.user unless project_member.nil?
  end

  def members
    self.project_members.reject do |project_member|
      project_member.project_role.eql? ProjectRole.manager
    end
  end

  def project_member_role(user)
    project_member = self.project_members.where({:user_id => user})[0]
    project_member.project_role unless project_member.nil?
  end
end
