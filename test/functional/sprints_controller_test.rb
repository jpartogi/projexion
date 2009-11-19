require 'test_helper'

class SprintsControllerTest < ActionController::TestCase
  fixtures :all

  def test_index
    get(:index, {:project_id => "PR"})
    assert_response :success
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:sprint)
    assert_not_nil assigns(:sprints)
  end

end