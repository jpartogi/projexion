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
  end
end