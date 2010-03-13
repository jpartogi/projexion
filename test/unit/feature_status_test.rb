require 'test_helper'
require 'shoulda'

class FeatureStatusTest < ActiveSupport::TestCase
 fixtures :all

  context "A Task status instance" do
    should "update the position" do
      feature_status = FeatureStatus.find(2)

      assert feature_status.update_position(FeatureStatus::DIRECTION_UP)
      assert_equal feature_status.position, 1
      assert_equal feature_status.default_status, true

      feature_status_1 = FeatureStatus.find(1)
      assert_equal feature_status_1.position, 2
      assert_equal feature_status_1.default_status, false

      assert feature_status.update_position(FeatureStatus::DIRECTION_DOWN)
      assert_equal feature_status.position, 2
      assert_equal feature_status.default_status, false
    end

    should "update the default status" do
      feature_status = FeatureStatus.find(3)

      feature_status.default_status = true
      assert feature_status.save

      assert_equal feature_status.default_status, true
      assert_equal feature_status.position, 1

      # Make sure there's only one default status
      assert_equal FeatureStatus.count(:conditions => {:default_status => true}), 1
    end
  end
end