require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  def setup
    UserSession.create(users(:admin))
    Factory(:sprint)
  end
  
  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects) 
  end

  test "show" do
    get(:show, {:id => 'PR'})
    
    assert_response :success

    assert_not_nil assigns(:project)
    assert_not_nil assigns(:manager)
    assert_not_nil assigns(:releases)
    assert_not_nil assigns(:sprints)
    assert_not_nil assigns(:sprint)
    assert_not_nil assigns(:features)
  end

#  def test_create
#    post(:create, :project => {:name => 'Projexion', :code => 'PR', :vision => 'To be the best agile project management tool'})
#    assert_response :success
#    assert_not_nil assigns(:project)
#  end
end