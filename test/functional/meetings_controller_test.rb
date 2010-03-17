require 'test_helper'

class MeetingsControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  test "index" do
    UserSession.create(users(:admin))

    get(:index, {:project_id => "PR"})

    assert_response :success
  end

  test "create" do
    UserSession.create(users(:admin))

    assert_difference('Meeting.count') do
      post :create, :meeting => {:meeting_type_id => '1', :minutes => 'What do we need',
                    :start_time => Date.today, :end_time => Date.today},
                    :project_id => 'PR'
    end

    assert_redirected_to project_meeting_path(assigns(:project).code, assigns(:meeting)) 
    
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:sprint)
    assert_not_nil assigns(:meeting)
  end
end