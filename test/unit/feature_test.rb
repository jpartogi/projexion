require 'test_helper'
require 'factories'

class FeatureTest < ActiveSupport::TestCase
  context "Feature instance" do
    should "be saved" do
      priority = Factory(:priority)
      release = Factory(:release)
      sprint = Factory(:sprint)
      project = Factory(:project)
      feature = Feature.create!(:user_story => 'should', :business_value => 100.0, :story_points => 5,
                               :priority => priority, :sprint => sprint, :release => release, :project => project)
    end
  end

  def teardown
    Feature.all.destroy_all
  end
end