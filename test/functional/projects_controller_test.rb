require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  fixtures :all
  
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:projects) 
  end

  def test_show
    get(:show, {:code => 'PR'})
    assert_response :success
    assert_not_nil assigns(:project)
  end

end