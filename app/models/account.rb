class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subdomain
  field :time_zone

  references_many :users
  references_many :companies
  references_many :projects
  references_many :project_roles
  references_many :meeting_types
  references_many :priorities
  references_many :task_statuses
  references_many :feature_statuses

  referenced_in :company

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :companies

  validates_presence_of :subdomain

  before_create :set_defaults

  def manager_role
    self.project_roles.where(:manager => true).first
  end

  def set_defaults
    TaskStatus.create(:display_name => 'New', :color => '0f0bbb', :default => true, :first => true)
  end
end