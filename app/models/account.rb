class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subdomain
  field :time_zone

  references_many :users
  references_many :projects
  references_many :project_roles
  references_many :meeting_types
  references_many :priorities

  accepts_nested_attributes_for :users
end