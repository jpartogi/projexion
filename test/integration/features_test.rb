require 'test_helper'

class FeaturesTest < ActionController::IntegrationTest

  def test_visit_project_feature
    visit project_feature_path('PR','1')
    assert_response :success
  end

end