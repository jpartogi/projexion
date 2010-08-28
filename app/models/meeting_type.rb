class MeetingType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :occurrence
  field :description

  referenced_in :account

  references_many :meetings

  validates_presence_of :name, :description
end