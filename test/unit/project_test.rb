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

    should "get the member project role" do
      project = projects(:projexion)
      user = users(:admin)
      scrum_master = project_roles(:scrum_master)

      project_role = project.project_member_role(user)

      assert_equal scrum_master, project_role
    end

    should "get the project manager" do
      project = projects(:projexion)
      user = users(:admin)

      manager = project.manager

      assert_equal user, manager
    end

    should "not get the project manager" do
      project = Factory(:dummy)
      manager = project.manager

      assert_nil manager
    end
  end
end