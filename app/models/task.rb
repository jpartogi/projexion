class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :done
  field :description

  referenced_in :account
  referenced_in :project
  referenced_in :user
  referenced_in :feature
  referenced_in :sprint
  referenced_in :task_statuses # This is actually referring to a task status. Because there is bug, we pluralize it.

  validates_presence_of :description

#  belongs_to :project
#  belongs_to :feature
#  belongs_to :sprint
#  belongs_to :task_status
#  belongs_to :user

  before_create :set_default_status
  after_save :add_event

  def set_default_status
    #self.task_status = TaskStatus.find(:first, :conditions => {:default_status => true})
    self.task_statuses = account.task_statuses.find(:first, :conditions => {:default => true})
  end

  def add_event
    if self.new_record?
      event = 'created'
    else
      event = 'modified'
    end

    Event.add event, self.class.to_s, self.id, self.project
  end

  class << self
    def board(*args)
      features = Feature.all(*args)
      task_statuses = TaskStatus.all(:order => 'position')

      features_map = Hash.new

      features.each do |feature|

        statuses_map = Hash.new

        task_statuses.each do |task_status|
          logger.debug task_status.display_name
          tasks = Task.includes(:user).where(:feature_id => feature.id, :task_status_id => task_status.id)
          statuses_map.store task_status, tasks
        end

        features_map.store feature, statuses_map
      end

      features_map
    end
  end
end