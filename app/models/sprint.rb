class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :features
  
  validates_presence_of :start_date, :end_date

  def span_date
    "#{self.start_date.to_formatted_s} - #{self.end_date.to_formatted_s}"
  end

  def generate_velocities
    features = Feature.all( :conditions => { :sprint_id => self.id, :accepted => true } )

    velocities = 0
    features.each do |feature|
      velocities += feature.story_points
    end

    self.velocities = velocities
    self.save
  end
end
