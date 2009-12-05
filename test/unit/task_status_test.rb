require 'test_helper'
require 'shoulda'

class TaskStatusTest < ActiveSupport::TestCase
  fixtures :all

  context "A Task status instance" do
    should "assign the next position" do
      task_status = TaskStatus.new
      task_status.display_name = 'Verified'
      task_status.key = 'verified'
      task_status.color = '#000'

      assert task_status.save
      assert_equal task_status.position, 4
    end

    should "update the position" do
      task_status = TaskStatus.find(9999)
      
      assert task_status.update_position('down')
      assert_equal task_status.position, 2
    end
  end
end