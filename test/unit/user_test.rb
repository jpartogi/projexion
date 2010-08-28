require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "User instance" do
    should "be added to project" do
      user = User.create!(:email => 'foo@example.com', :password => 'blahblah')
      project = Project.create!(:name => 'Projexion', :code => 'projexion', :vision => 'To be the best')
      project_member = ProjectMember.new
      project_member.user_id = user.id

      project.project_members << project_member
      project.save
    end
  end

  def destroy
    Project.all.destroy
    User.all.destroy
  end
end
