class TaskDaily < ActiveRecord::Base
  belongs_to :project, :primary_key => :code, :foreign_key => :project_code

  # Class methods
  class << self
    def sum_daily_tasks

      projects = Project.all

      for project in projects
        sum_daily_task(project)
      end

    end

    def sum_daily_task(project)
      unless project.is_a? Project
        raise TypeError, "A Project instance is expected"
      end

      task_statuses = TaskStatus.last(:order => "position")
    
      tasks = Task.all(:conditions => [ "task_status_id NOT IN (?) AND project_code = ?", task_statuses, project.code ])

      task_daily = today_sum
      if task_daily.nil?
        task_daily = self.new
      end

      task_daily.total_tasks = tasks.length
      task_daily.last_update = Date.today
      task_daily.tstamp = Date.today
      task_daily.project = project
      task_daily.save
    end

    private
      def today_sum
        today = Date.today
        #TODO: Check this with timestamp instead
        TaskDaily.first(:conditions => { :last_update => today })
      end
  end  
end