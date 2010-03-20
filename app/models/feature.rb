class Feature < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  belongs_to :feature_status
  has_many :tasks
  has_many :acceptances
  #TODO: Delete cascade or soft delete?
  validates_presence_of :user_story

  before_create :set_default_status
  after_save :add_event
  
  def acceptances=(acceptances)
    @acceptances = acceptances 
  end

  def set_default_status
    self.feature_status = FeatureStatus.first(:conditions => {:default_status => true})
  end

  def add_event
    if self.new_record?
      event = 'created'
    else
      event = 'modified'
    end

    Event.add event, self.class.to_s, self.id, self.project
  end

  def save_all
    Feature.transaction do
      self.save

      @acceptances.each do |a|
        acceptance = Acceptance.new
        acceptance.description = a
        acceptance.feature = self
        acceptance.save
      end
    end
  end
end