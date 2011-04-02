class Priority
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :color
  field :level, :type => Integer
  field :position, :type => Integer, :default => 1 # TODO: Remove this
  
  referenced_in :account
  
  references_many :features

  scope :ordered, asc(:level)
  
  validates_presence_of :display_name, :color, :level
  validates_numericality_of :level

  def hash_color
    "#"+self.color
  end

  def display_name
    "#{self.level}: #{self.name}"
  end
end
