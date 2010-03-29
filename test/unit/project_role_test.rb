require 'test_helper'
require 'shoulda'

class ProjectRoleTest < ActiveSupport::TestCase
  setup :activate_authlogic
  fixtures :all

  context "Project role instance" do
    should "get project manager role" do
      scrum_master = project_roles(:scrum_master)

      manager = ProjectRole.manager

      assert_equal scrum_master, manager
    end
  end
end