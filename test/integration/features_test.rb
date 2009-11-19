require 'test_helper'

class FeaturesTest < ActionController::IntegrationTest

  def test_visit_project_feature
    visit project_feature_path('PR','9999')
  end

end