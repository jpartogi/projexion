class Acceptance < ActiveRecord::Base
  belongs_to :feature

  # Class method
  class << self
    def to_a(acceptances)
      acceptances.strip.split("-").reject{ |x| x.empty? }
    end
  end
end