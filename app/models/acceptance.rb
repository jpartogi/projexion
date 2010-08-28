class Acceptance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description
  field :accepted, :type => Boolean

  referenced_in :feature
  
  validates_presence_of :description
  
  # Class methods
  class << self
    def to_a(acceptances)
      acceptances.strip.split("-").reject{ |x| x.empty? }
    end
  end
end