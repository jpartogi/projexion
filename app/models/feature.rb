class Feature < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  has_many :tasks
  has_many :acceptances
  
  validates_presence_of :user_story

  after_save :add_event
  
  def acceptances=(acceptances)
    @acceptances = acceptances 
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