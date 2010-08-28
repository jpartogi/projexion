class Priority
  include Mongoid::Document
  include Mongoid::Timestamps

  field :display_name
  field :color
  field :level, :type => Integer
  field :default, :type => Boolean

  referenced_in :account
  
  references_many :features

  validates_presence_of :display_name, :color, :level
  validates_numericality_of :level
  
  def priority_level
    "#{self.display_name}: #{self.level}"
  end

  def hash_color
    '#'+self.color
  end
end
