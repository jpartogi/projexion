require 'spec_helper'

describe FeatureStatus do
  before(:each) do
    FeatureStatus.destroy_all
  end

  it "should set default position" do
    status = FeatureStatus.create(:display_name => 'Done', :key => 'done', :color => 'ccc')
    status.position.should eq(1)

    status = FeatureStatus.create(:display_name => 'In Progress', :key => 'in-progress', :color => '000')
    status.position.should eq(2)
  end

  it "should update position" do
    Factory.create(:feature_status_pooled)

    status = Factory.create(:feature_status_done)

    status.update_position(FeatureStatus::DIRECTION_UP)
    status.position.should eq(1)
    status.default.should eq(true)

    status.update_position(FeatureStatus::DIRECTION_DOWN)
    status.position.should eq(2)
  end

  it "should only have one default status" do
    status = Factory.create(:feature_status_done)
    status.default = true
    status.save

    status.default.should eq(true)

    FeatureStatus.count(:conditions => {:default => true}).should eq(1)
  end
end