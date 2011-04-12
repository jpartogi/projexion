class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subdomain
  field :time_zone

  references_many :users
  references_many :companies
  references_many :projects
  references_many :events
  references_many :project_roles
  references_many :meeting_types
  references_many :priorities
  references_many :task_statuses
  references_many :feature_statuses

  referenced_in :owner, :class_name => 'User'
  referenced_in :company

  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain

  before_create :set_defaults

  def set_defaults
    TaskStatus.create(:display_name => 'Pooled', :color => '0f0bbb', :account => self)
    TaskStatus.create(:display_name => 'Done', :color => '00ff00', :account => self)

    FeatureStatus.create(:display_name => 'New', :color => '0f0bbb', :account => self)
    FeatureStatus.create(:display_name => 'Done', :color => '00ff00', :account => self)

    Priority.create(:name => 'Low', :color => '0f0bbb', :level => 10)
    Priority.create(:name => 'High', :color => '00ff00', :level => 30)

    ProjectRole.create(:name => 'Scrum Master', :role => 'Enforce the scrum process is running')
    ProjectRole.create(:name => 'Product Owner', :role => 'Maximize product\'s ROI')
    ProjectRole.create(:name => 'Developer', :role => 'Develop the product')
  end

end