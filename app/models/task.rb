class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :feature
  belongs_to :sprint
  belongs_to :task_status
  belongs_to :user

  validates_presence_of :description

  before_create :set_default_status
  before_save :set_user
  after_save :add_event

  def set_default_status
    self.task_status = TaskStatus.find(:first, :conditions => {:default_status => true})
  end

  def set_user
    self.user = UserSession.current_user  
  end

  def add_event
    if self.new_record?
      event = 'created'
    else
      event = 'modified'
    end

    Event.add event, self.class.to_s, self.id, self.project
  end

  def remaining
    sql = 'select count(t.id) as tasks, date(t.updated_at) updated_at
        from tasks t inner join task_statuses ts on t.task_status_id = ts.id
        where t.task_status_id <> (select max(ts.position) from task_statuses ts)
        group by date(t.updated_at)
        order by t.updated_at'
  end

  class << self
    def board(*args)
      features = Feature.all(*args)
      task_statuses = TaskStatus.all(:order => 'position')

      features_map = Hash.new

      features.each do |feature|

        statuses_map = Hash.new

        task_statuses.each do |task_status|
          
          tasks = Task.all(:conditions => { :feature_id => feature.id, :task_status_id => task_status.id})
          statuses_map.store task_status, tasks
        end

        features_map.store feature, statuses_map
      end

      features_map
    end
  end
end
