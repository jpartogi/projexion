class FeatureStatus < ActiveRecord::Base
  has_many :features

  before_create :set_next_position
  before_save :check_and_update_default_status

  validates_presence_of :display_name, :key, :color

  DIRECTION_UP = 'up'
  DIRECTION_DOWN = 'down'

  def hash_color
    '#'+self.color
  end
  
  def set_next_position
    last_status = FeatureStatus.last_status

    unless last_status.nil?
      self.position = last_status.position + 1
    end
  end

  def check_and_update_default_status
    if default_status_available? and not @bypass and self.default_status
      update_default_status
      self.position = 1
    end
  end

  def update_position(direction)
    position = self.position

    if direction.eql? DIRECTION_UP
      changed_status = FeatureStatus.find_by_position(position.to_i - 1)
    elsif direction.eql? DIRECTION_DOWN
      changed_status = FeatureStatus.find_by_position(position.to_i + 1)
    end

    self.position = changed_status.position
    logger.debug "Target position: " + self.position.to_s

    changed_status.position = position
    logger.debug "Changed position: " + changed_status.position.to_s

    @bypass = true #We want to bypass the interceptor because there are two instance.save

    # Let's make sure first position is always the default status
    if self.position == 1
      self.default_status = true
    else
      self.default_status = false
    end

    if changed_status.position == 1
      changed_status.default_status = true
    else
      changed_status.default_status = false
    end

    FeatureStatus.transaction do
      self.save
      changed_status.save
    end

    return self
  end

  private
    def default_status_available?
      @current_default = FeatureStatus.default_status

      not @current_default.nil? # reverse it
    end

    def update_default_status
      # Change the current default status to make sure there's only one default status
      @current_default.default_status = false
      @current_default.position = self.position

      @current_default.save
    end
  
  # Class methods
  class << self

    def default_status
      FeatureStatus.first(:conditions => {:default_status => true})
    end

    def first_status
      FeatureStatus.first(:conditions => {:position => 1})
    end

    def last_status
      FeatureStatus.last(:order => :position)
    end
  end
end