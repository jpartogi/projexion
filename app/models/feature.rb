class Feature < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :release
  belongs_to :project
  has_many :tasks
  has_many :acceptances
  
  validates_presence_of :user_story

  def acceptances=(acceptances)
    @acceptances = acceptances 
  end

  def save_all
    Feature.transaction do
      self.save

      @acceptances.each do |a|
        acceptance = Acceptance.new
        acceptance.description = a
        acceptance.feature = Feature.find(self.id)
        acceptance.save
      end
    end
  end
end