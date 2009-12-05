require 'test_helper'
require 'shoulda'

class FeatureTest < ActiveSupport::TestCase
  
  def test_acceptance_test
    acceptance_test = "
    User shall be able to save data
    User shall be able to modify data
    "

    assert_equal acceptance_test.strip.split("\n").length, 2

  end
end