class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subdomain
  field :time_zone

  references_many :users, :dependent => :destroy
  references_many :companies, :dependent => :destroy
  references_many :projects, :dependent => :destroy
  references_many :project_roles, :dependent => :destroy
  references_many :priorities, :dependent => :destroy
  references_many :task_statuses, :dependent => :destroy
  references_many :feature_statuses, :dependent => :destroy

  referenced_in :owner, :class_name => 'User'
  referenced_in :company

  index :subdomain, :unique => true, :background => true

  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain

  before_create :set_defaults

  def set_defaults
    TaskStatus.create(:display_name => 'Pooled', :color => '0f0bbb', :account => self)
    TaskStatus.create(:display_name => 'Done', :color => '00ff00', :account => self)

    FeatureStatus.create(:display_name => 'New', :color => '0f0bbb', :account => self)
    FeatureStatus.create(:display_name => 'Done', :color => '00ff00', :account => self)

    Priority.create(:name => 'Low', :color => '0f0bbb', :level => 10, :account => self)
    Priority.create(:name => 'High', :color => '00ff00', :level => 30, :account => self)

    ProjectRole.create(:name => 'Scrum Master', :role => 'Enforce the scrum process is running', :account => self)
    ProjectRole.create(:name => 'Product Owner', :role => 'Maximize product\'s ROI', :account => self)
    ProjectRole.create(:name => 'Developer', :role => 'Develop the product', :account => self)

    Project.create(:name => 'Test', :vision => 'Just for testing purposes.', :account => self)
  end

end