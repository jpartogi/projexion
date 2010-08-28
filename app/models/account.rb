class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subdomain
  field :time_zone

  references_many :users
  references_many :projects
  references_many :project_roles

  accepts_nested_attributes_for :users
end