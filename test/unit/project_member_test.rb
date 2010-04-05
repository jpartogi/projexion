require 'test_helper'
require 'shoulda'

class ProjectMemberTest < ActiveSupport::TestCase
  fixtures :all

  context "Project member instance" do
    should "validate when a manager exists" do
      project_member = ProjectMember.new
      scrum_master = project_roles(:scrum_master)
      project = projects(:projexion)
      user = users(:admin)

      project_member.project_role = scrum_master
      project_member.project = project
      project_member.user = user

      assert project_member.invalid?, "Project member is invalid"
    end
  end
end