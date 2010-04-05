class Acceptance < ActiveRecord::Base
  belongs_to :feature

  validates_presence_of :description
  
  # Class methods
  class << self
    def to_a(acceptances)
      acceptances.strip.split("-").reject{ |x| x.empty? }
    end
  end
end