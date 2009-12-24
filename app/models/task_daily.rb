class TaskDaily < ActiveRecord::Base
  # Class methods
  class << self
    def sum_daily_tasks
      sql = "select count(*)
          from tasks t inner join task_statuses ts on t.task_status_id = ts.id
          where t.task_status_id <> (select max(ts.position) from task_statuses ts)
          group by date(t.updated_at)"

      tasks = Task.count_by_sql(sql)

      task_dailies = self.new
      task_dailies.total_tasks = tasks
      task_dailies.save
    end
  end  
end