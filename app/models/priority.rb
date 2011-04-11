class Priority
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :color
  field :level, :type => Integer
  
  referenced_in :account
  
  references_many :features

  scope :ordered, asc(:level)
  
  validates_presence_of :name, :color, :level
  validates_numericality_of :level

  def hash_color
    "#"+self.color
  end

  def display_name
    "#{self.level}: #{self.name}"
  end
end
