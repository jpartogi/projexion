require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  test "index" do
    UserSession.create(users(:admin))

    get :index
    assert_response :success
    assert_not_nil assigns(:projects) 
  end

  test "show" do
    UserSession.create(users(:admin))

    get(:show, {:id => 'PR'})
    
    assert_response :success
    assert_not_nil assigns(:project)
  end

#  def test_create
#    post(:create, :project => {:name => 'Projexion', :code => 'PR', :vision => 'To be the best agile project management tool'})
#    assert_response :success
#    assert_not_nil assigns(:project)
#  end
end