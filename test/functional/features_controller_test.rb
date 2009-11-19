require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  fixtures :all

  def test_show
    get(:show, {:id => '9999'})
    assert_response :success
    assert_not_nil assigns(:feature)
    assert_not_nil assigns(:task)
    assert_not_nil assigns(:tasks)
    assert_not_nil assigns(:project)
  end

  def test_index_from_release
    get(:index, {:release_id => '9999'})
    assert_response :success
    assert_not_nil assigns(:release)
    assert_not_nil assigns(:features)
    assert_not_nil assigns(:project)
  end

  def test_index_from_sprint
    get(:index, {:sprint_id => '9999'})
    assert_response :success
    assert_not_nil assigns(:sprint)
    assert_not_nil assigns(:features)
    assert_not_nil assigns(:project)
  end
end