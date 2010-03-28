require 'test_helper'
require 'shoulda'

class ProjectTest < ActiveSupport::TestCase
  setup :activate_authlogic
  fixtures :all

  context "Project instance" do
    should "get the current sprint" do
      project = Factory(:projexion)
      
      sprint = project.current_sprint
    end

  end
end