require 'spec_helper'

describe ProjectMembersController do
  render_views

  before :each do
    User.destroy_all
    Account.destroy_all
    Project.destroy_all
    ProjectRole.destroy_all

    request.host= 'scrum8.projexion.dev:3000'

    @project = Factory.create(:project)
    @user = @project.account.owner
    @project_role = @project.account.project_roles.first

    sign_in @user
  end

  it "should create project member" do
    post :create, { :project_member => { :user_id => @user.id,
                                         :project_role_id => @project_role.id },
                    :project_id => @project.code}

  end
end