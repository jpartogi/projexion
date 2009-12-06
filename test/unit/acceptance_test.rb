require 'test_helper'
require 'shoulda'

class AcceptanceTest < ActiveSupport::TestCase
  def test_to_array
    acceptance_test = "
    - User shall be able to save data
    - User shall be able to modify data
    "

    acceptances = Acceptance.to_a(acceptance_test)
    assert_equal acceptances.length, 2
  end
end