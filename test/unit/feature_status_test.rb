require 'test_helper'
require 'shoulda'

class FeatureStatusTest < ActiveSupport::TestCase
 fixtures :all

  context "A Task status instance" do
    should "update the position" do
      feature_status = FeatureStatus.find(1)

      assert feature_status.update_position('down')
      assert_equal feature_status.position, 2
    end
  end
end