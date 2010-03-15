class ReleaseSnapshot < ActiveRecord::Base
  belongs_to :project
  belongs_to :release
  belongs_to :sprint

  class << self
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