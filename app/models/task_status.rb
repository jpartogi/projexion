class TaskStatus
  include Mongoid::Document
  include Mongoid::Timestamps

  field :display_name
  field :key
  field :position, :type => Integer
  field :default, :type => Boolean
  field :color
  field :first, :type => Boolean
  field :last, :type => Boolean

  referenced_in :account
  
  references_many :tasks

  before_create :check_and_update_default_status, :set_next_position
  before_update :check_and_update_default_status

  validates_presence_of :display_name, :key, :color
  
  def hash_color
    '#'+self.color  
  end

  def set_next_position
    last_status =  TaskStatus.last_status

    unless last_status.nil?
      self.position = last_status.position + 1
    end
  end

  def check_and_update_default_status
    default = TaskStatus.default_status

    unless default.nil?
      if self.default_status and not @bypass
        # Change the current default status to make sure there's only one default status
        default.default_status = false
        default.save
      end
    end
  end

  def update_position(direction)
    position = self.position

    if direction.eql? 'up'
      status = TaskStatus.find_by_position(position.to_i - 1)
    else
      status = TaskStatus.find_by_position(position.to_i + 1)
    end

    self.position = status.position
    status.position = position

    TaskStatus.transaction do
      @bypass = true
      self.save
      status.save
    end

    return self
  end
  
  # Class methods
  class << self

    def default_status
      self.first(:conditions => {:default_status => true})
    end

    def last_status
      self.asc(:position).last
    end

  end
end