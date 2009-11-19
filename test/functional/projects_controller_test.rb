require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  fixtures :all
  
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:projects) 
  end

end