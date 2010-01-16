require 'test_helper'
require 'shoulda'

class SprintTest < ActiveSupport::TestCase
  fixtures :all

  context "A Sprint instance" do
    should "generate velocities" do
      sprint = Sprint.find(9999)
      
      sprint.generate_velocities
    end
  end
end