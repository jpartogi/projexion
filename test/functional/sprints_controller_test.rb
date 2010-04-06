require 'test_helper'

class SprintsControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  test "index" do
    UserSession.create(users(:admin))

    get(:index, {:project_id => "PR"})

    assert_response :success
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:sprints)
  end

  test "create" do
    UserSession.create(users(:admin))

    post :create, :sprint => {:goal => 'Deliver usable product',
                              :start_date => '1900-01-01', :end_date => '1901-01-01'},
                  :project_id => 'PR'

    assert_response :success
    assert_not_nil assigns(:sprint)
  end
end