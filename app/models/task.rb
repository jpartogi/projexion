class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :feature
  belongs_to :sprint
  belongs_to :task_status
  belongs_to :user

  validates_presence_of :description

  before_create :set_default_status
  after_save :add_event

  def set_default_status
    self.task_status = TaskStatus.find(:first, :conditions => {:default_status => true})
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
          puts task_status.display_name
          tasks = Task.all(:conditions => { :feature_id => feature.id, :task_status_id => task_status.id})
          statuses_map.store task_status, tasks
        end

        features_map.store feature, statuses_map
      end

      features_map
    end
  end
end
