require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  test "show" do
    UserSession.create(users(:admin))
    
    get(:show, {:project_id => '9999', :id => '1'})

    assert_response :success
    assert_not_nil assigns(:feature)
    assert_not_nil assigns(:task)
    assert_not_nil assigns(:tasks)
    assert_not_nil assigns(:project)
  end
end