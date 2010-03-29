class Priority < ActiveRecord::Base
  has_many :features

  validates_numericality_of :level
  
  def priority_level
    "#{self.display_name}: #{self.level}"
  end

  def hash_color
    '#'+self.color
  end
end
