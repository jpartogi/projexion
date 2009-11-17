require 'test_helper'

class FeaturesTest < ActionController::IntegrationTest

  def test_update_task
    visit project_feature_path('PR', '9999')
  end

end