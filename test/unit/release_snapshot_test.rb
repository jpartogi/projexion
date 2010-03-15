require 'test_helper'
require 'shoulda'

class ReleaseSnapshotTest < ActiveSupport::TestCase
  fixtures :all
  
  context "Release snapshot" do
    should "get plots" do
      project = projects(:projexion)
      release = releases(:one)
      plots = ReleaseSnapshot.plots(:conditions => {:project_id => project, :release_id => release})

      assert_equal plots.size, 3
    end

    should "generate" do
      release = releases(:one)

      assert ReleaseSnapshot.generate(release)

      sprint = sprints(:one)
      sprint.start_date = Date.today
      sprint.save
      
      snapshots = ReleaseSnapshot.all
      assert_equal snapshots.size, 4
    end
  end
end