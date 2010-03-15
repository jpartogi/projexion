require 'test_helper'
require 'shoulda'

class SprintTest < ActiveSupport::TestCase
  fixtures :all

  context "A Sprint instance" do
    should "generate velocities" do
      sprint = sprints(:one)
      
      sprint.generate_velocities
    end
  end
end