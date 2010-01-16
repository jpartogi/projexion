class Task < ActiveRecord::Base
  belongs_to :project, :primary_key => :code, :foreign_key => :project_code
  belongs_to :feature
  belongs_to :task_status

  validates_presence_of :description
  
  before_create :set_default_status
  after_update :add_event

  def set_default_status
    self.task_status = TaskStatus.find(:first, :conditions => {:default_status => true})
  end

  def add_event
    Event.add 'modified', self.class.to_s, self.id, self.project
  end

  def remaining
    sql = 'select count(t.id) as tasks, date(t.updated_at) updated_at
        from tasks t inner join task_statuses ts on t.task_status_id = ts.id
        where t.task_status_id <> (select max(ts.position) from task_statuses ts)
        group by date(t.updated_at)
        order by t.updated_at'
  end
end

