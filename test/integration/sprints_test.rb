require 'test_helper'

class SprintsTest < ActionController::IntegrationTest

  def test_visit_project_sprint
    visit project_sprints_path('PR')
    assert_response :success
  end

  def test_create_sprint
    visit new_project_sprint_path('PR')
    fill_in "sprint_goal", :with => "Deliver usable product for product owner"
    click_button "Save"
  end
end