require 'test_helper'

class ReleasesTest < ActionController::IntegrationTest

  def test_visit_project_release
    visit project_releases_path('PR')
    assert_response :success
  end

end