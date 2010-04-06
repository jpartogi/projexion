require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  test "show" do
    UserSession.create(users(:admin))
    
    get(:show, {:project_id => projects(:projexion).to_param, :id => features(:one).to_param})

    assert_response :success
    assert_not_nil assigns(:feature)
    assert_not_nil assigns(:task)
    assert_not_nil assigns(:tasks)
    assert_not_nil assigns(:project)
  end
end