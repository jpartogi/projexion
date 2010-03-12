class FeatureStatus < ActiveRecord::Base
  has_many :features

  before_create :check_and_update_default_status, :set_next_position
  before_update :check_and_update_default_status

  def set_next_position
    last_status = FeatureStatus.find(:last, :order => "position")

    unless last_status.nil?
      self.position = last_status.position + 1
    end
  end

  def check_and_update_default_status
    default = FeatureStatus.default_status

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
      status = FeatureStatus.find_by_position(position.to_i - 1)
    else
      status = FeatureStatus.find_by_position(position.to_i + 1)
    end
    
    self.position = status.position
    status.position = position

    FeatureStatus.transaction do
      @bypass = true
      self.save
      status.save
    end

    return self
  end

  # Class methods
  class << self

    def default_status
      FeatureStatus.first(:conditions => {:default_status => true})
    end

  end
end