require 'test_helper'

class ReleasesControllerTest < ActionController::TestCase
  fixtures :all

  def test_index
    get(:index, {:project_id => "PR"})
    assert_response :success
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:release)
    assert_not_nil assigns(:releases)
  end
  
end