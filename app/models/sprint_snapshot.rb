class SprintSnapshot < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint

  # Class methods
  class << self
    def generate(sprint)
      project = sprint.project
      
      status = TaskStatus.last_status

      tasks = Task.where(['task_status_id not in(?) and sprint_id = ?', status, sprint])

      snapshot = today_snapshot
      if snapshot.nil?
        snapshot = self.new
      end

      total = tasks.size

      snapshot.total = total
      snapshot.last_update = Date.today
      snapshot.updated = Date.today
      snapshot.project = project
      snapshot.sprint = sprint
      snapshot.save
      
    end

    def job
      projects = Project.all

      projects.each do |project|
        sprint = project.current_sprint

        unless sprint.nil?
          generate(sprint)
        end
      end
    end

    def plots(*args)
      snapshots = SprintSnapshot.all(*args)

      plots = Hash.new

      snapshots.each do |snapshot|
        plots[snapshot.updated.to_time.to_i * 1000] = snapshot.total
      end

      plots
    end

    private
      def today_snapshot
        today = Date.today
        #TODO: Check this with timestamp instead
        SprintSnapshot.first(:conditions => { :last_update => today })
      end
  end  
end