class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :code
  field :vision 

  referenced_in :account
  references_and_referenced_in_many :users, :inverse_of => :projects
  references_many :tasks
  references_many :features
  references_many :releases
  references_many :sprints
  references_many :project_members
  
  validates_presence_of :name, :vision
  validates_uniqueness_of :code, :scope => :account_id

  before_create :set_defaults

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
    self.releases.where(:released_at => nil) # TODO : Or current date less than estimate release date?
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

  def set_defaults
    release = Release.create(:version_number =>'0.1.0', :goal => 'Release initial product.', :project => self)

    Sprint.create(:name => '1st sprint', :start_date => Time.now, :end_date => Time.now + 1.fortnights, :release => release, :project => self)
  end
end
