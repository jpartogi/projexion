require 'integration_test_helper'

class SprintsTest < ActionController::IntegrationTest

  def test_visit_project_sprint
    visit project_sprints_url('PR')
    assert_response :success
  end

  def test_create_sprint
    visit new_project_sprint_url('PR')
    assert_contain 'Sprint goal'
    assert_response :success

    fill_in "Sprint goal", :with => "Deliver usable product for product owner"
    click_button "Save"
  end
end