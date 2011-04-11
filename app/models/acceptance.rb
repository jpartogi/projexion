class Acceptance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description
  field :accepted, :type => Boolean

  referenced_in :feature
  
  validates_presence_of :description
  
end