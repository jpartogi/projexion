class Feature
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_story
  field :business_value, :type => Float
  field :story_points, :type => Integer
  
  referenced_in :sprint
  referenced_in :release
  referenced_in :priority
  referenced_in :project
  referenced_in :feature_status
  references_many :tasks
  references_many :acceptances

#  belongs_to :sprint
#  belongs_to :release
#  belongs_to :priority
#  belongs_to :project
#  belongs_to :feature_status
#  has_many :tasks
#  has_many :acceptances
#  #TODO: Delete cascade or soft delete?

  validates_presence_of :user_story, :business_value, :story_points, :priority
  validates_numericality_of :business_value, :story_points

  before_create :set_default_status
  after_create :save_acceptances
  
  def acceptances=(acceptances)
    @acceptances = acceptances
  end

  def set_default_status
    self.feature_status = FeatureStatus.first(:conditions => {:default_status => true})
  end

  def save_acceptances
    @acceptances.each do |a|
      acceptance = Acceptance.new
      acceptance.description = a
      acceptance.feature = self
      acceptance.save
    end
  end
end