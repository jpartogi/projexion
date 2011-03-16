class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :code
  field :vision 

  referenced_in :account
  references_and_referenced_in_many :users, :inverse_of => :projects
  references_many :meetings
  references_many :tasks
  references_many :features
  references_many :releases
  references_many :sprints
  references_many :project_members
  
  validates_presence_of :name, :vision
  validates_uniqueness_of :code, :scope => :account_id

#  has_many :project_members
#  has_many :users, :through => :project_members
#  has_many :features
#  has_many :releases
#  has_many :sprints

  def code
    self.code = self.name.gsub(/\s+/, '-').strip.downcase
  end

  def active_sprints
    self.sprints.where(:end_date.gt => Time.now.beginning_of_day, :cancelled_at => nil).asc(:start_date)
  end

  def current_sprint
    self.sprints.where(:start_date.lte => Time.now.beginning_of_day, :end_date.gte => Time.now.end_of_day, :cancelled_at => nil).first
  end
#
#  def latest_sprint
#    self.sprints.where(['end_date = (select max(end_date) from sprints)'])
#  end
#
  def active_releases
    self.releases.where(:released_at => nil)
  end

  def manager
    project_member = self.project_members.where(:project_role_id => self.account.manager_role.id).first

    project_member.user unless project_member.nil?
  end

  def manager_exists?
    false if manager.nil?
  end

  def members
    self.project_members.reject do |project_member|
      project_member.project_role.eql? ProjectRole.manager(account)
    end
  end

  def project_member_role(user)
    project_member = self.project_members.where({:user_id => user})[0]
    project_member.project_role unless project_member.nil?
  end
end
