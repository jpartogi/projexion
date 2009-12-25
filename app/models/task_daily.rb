class TaskDaily < ActiveRecord::Base
  # Class methods
  class << self
    def sum_daily_tasks
      sql = "select count(*)
          from tasks t inner join task_statuses ts on t.task_status_id = ts.id
          where t.task_status_id <> (select max(ts.position) from task_statuses ts)
          group by date(t.updated_at)"

      tasks = Task.count_by_sql(sql)

      if today_sum_empty?
        task_daily = self.new
      else
        task_daily = today_sum
      end

      task_daily.total_tasks = tasks
      task_daily.last_update = Date.today
      task_daily.save
    end

    def today_sum_empty?
      if self.today_sum != nil
        return false
      else
        return true
      end
    end

    def today_sum
      today = Date.today

      TaskDaily.first(:conditions => { :last_update => today })
    end
  end  
end