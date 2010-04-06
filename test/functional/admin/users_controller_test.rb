require 'test_helper'

class Admin::UsersControllerTest  < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  def setup
    UserSession.create(users(:admin))      
  end

  test "show" do
    get :show, :id => sprints(:one).to_param
    assert_response :success 
  end

  test "destroy" do

    assert_difference(['User.count', 'ProjectMember.count'], -1) do
      delete :destroy, :id => users(:admin).to_param
    end

    assert_redirected_to admin_users_path
  end
end