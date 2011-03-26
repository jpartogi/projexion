class Sprint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :velocities, :type => Integer
  field :goal
  field :cancelled_at, :type => Time

  referenced_in :project
  referenced_in :release

  references_many :features
  references_many :meetings

  #validate :start_date_must_not_exists, :end_date_must_not_exists, :start_date_must_be_earlier_than_end_date

  validates_presence_of :start_date, :end_date, :release

  def span_date
    "#{self.start_date.to_formatted_s(:default)} - #{self.end_date.to_formatted_s(:default)}"
  end

  def generate_velocities
    features = Feature.all( :conditions => { :sprint_id => self.id, :feature_status_id => FeatureStatus.last_status } )

    velocities = 0
    features.each do |feature|
      velocities += feature.story_points
    end

    self.velocities = velocities
    self.save
  end

  def start_date_must_not_exists
    sprints = validate_span_date
    errors.add(:start_date, "already exists within existing sprint") if sprints.length > 0
  end

  def end_date_must_not_exists
    sprints = validate_span_date
    errors.add(:end_date, "already exists within existing sprint") if sprints.length > 0
  end

  def start_date_must_be_earlier_than_end_date
    errors.add(:start_date, "must not be later than end date") if start_date > end_date
  end

  private
    def validate_span_date
      sprints = Sprint.where(:start_date.lte => self.end_date, :end_date.gte => self.end_date)

      unless self.new_record?
        sprints = sprints.where(["id <> ?", self.id])
      end

      sprints
    end
end
