require 'spec_helper'

describe Project do
  before(:each) do
    Project.destroy_all  
  end

  it "should set code" do
    project = Project.create(:name => 'Projexion', :vision => 'To be the best agile management software')
    project.code.should eq('projexion')
  end
end