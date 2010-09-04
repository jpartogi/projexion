class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  referenced_in :account
end