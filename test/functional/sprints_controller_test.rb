require 'test_helper'

class SprintsControllerTest < ActionController::TestCase
  fixtures :all

  def test_index
    get(:index, {:project_id => "PR"})
    assert_response :success
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:sprints)
  end

  def test_create
    post :create, {:project_id => 'PR', :goal => 'Deliver usable product',
                              :start_date => '1900-01-01', :end_date => '1901-01-01'}
    assert_response :success
    assert_not_nil assigns(:sprint)
  end
end