require 'test_helper'

class Admin::ProjectsControllerTest < ActionController::TestCase
  fixtures :all
  setup :activate_authlogic

  def setup
    UserSession.create(users(:admin))
    Factory(:sprint)
  end

  test "create" do
    post(:create, :project => {:name => 'Projexion', :code => 'PR', :vision => 'To be the best agile project management tool'})
    assert_response :success
    assert_not_nil assigns(:project)
  end
end