require 'test_helper'

class SprintsTest < ActionController::IntegrationTest

  def test_visit_project_sprint
    visit project_sprints_path('PR')
    assert_response :success
  end

end