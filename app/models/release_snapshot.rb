class ReleaseSnapshot < ActiveRecord::Base
  belongs_to :project
  belongs_to :release
  belongs_to :sprint

  class << self
    def generate(release)

      project = release.project
      features = release.features

      sprint = project.current_sprint

      if sprint.empty?
        sprint = project.latest_sprint
      end

      unless sprint.empty?
        features = features.where(['sprint_id = ?',sprint])
      end

      features = features.where(['feature_status_id not in (?)', FeatureStatus.last_status])
      
      total = features.size
      sprint = Sprint.find(sprint) # Reload it as we don't want ActiveRecord::Relation

      snapshot = ReleaseSnapshot.new
      snapshot.total = total
      snapshot.project = project
      snapshot.release = release
      snapshot.sprint = sprint
      snapshot.save
    end

    def plots(*args)
      snapshots = ReleaseSnapshot.all(*args)

      plots = Hash.new

      snapshots.each do |snapshot|
        plots[snapshot.sprint.end_date.to_time.to_i * 1000] = snapshot.total
      end

      return plots
    end
  end
end