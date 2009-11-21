require 'test_helper'

class ReleasesControllerTest < ActionController::TestCase
  fixtures :all

  def test_index
    get(:index, {:project_id => "PR"})
    assert_response :success
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:releases)
  end

  def test_create
    post :create, {:project_id => 'PR', :version_number => '1.0.0', :estimate_date => '1900-01-01'}
    assert_response :success
    assert_not_nil assigns(:release)
  end
end