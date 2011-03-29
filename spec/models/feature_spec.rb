require 'spec_helper'

describe Feature do
  before(:each) do
    User.destroy_all
    Account.destroy_all
    FeatureStatus.destroy_all
    Project.destroy_all
    Priority.destroy_all

    @project = Factory.create(:project)
    
    @priority = Factory.create(:priority)
  end

  it "should set default status" do
    feature = Feature.create(:user_story => 'hello', :business_value => 1000, :story_points => 10, :priority => @priority, :project => @project)

    feature.should_not be nil
    feature.feature_statuses.should_not be nil
  end
end