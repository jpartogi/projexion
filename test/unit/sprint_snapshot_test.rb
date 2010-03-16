require 'test_helper'
require 'shoulda'

class SprintSnapshotTest < ActiveSupport::TestCase
  fixtures :all

  context "Sprint snapshot instance" do
    should "generate" do
      sprint = sprints(:one)

      assert SprintSnapshot.generate(sprint)

      snapshot = SprintSnapshot.first(:conditions => {:last_update => Date.today})

      assert_equal snapshot.total, 2
    end

  end

end