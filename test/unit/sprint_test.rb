require 'test_helper'
require 'shoulda'

require 'date'


class SprintTest < ActiveSupport::TestCase
  fixtures :all

  context "A Sprint instance" do
    should "generate velocities" do
      sprint = sprints(:one)
      
      sprint.generate_velocities
    end

    should "validate when sprint date exists" do
      sprint = Sprint.new

      sprint.start_date = Date.strptime('16/03/2010', "%d/%m/%Y")
      sprint.end_date = Date.strptime('18/03/2010', "%d/%m/%Y")
      sprint.project = projects(:projexion)
      sprint.release = releases(:one)

      assert sprint.invalid?, "Sprint is invalid"

    end
  end
end