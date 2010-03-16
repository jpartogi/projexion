require 'test_helper'
require 'shoulda'

class TaskTest < ActiveSupport::TestCase
  fixtures :all
  setup :activate_authlogic
  
  context "A Task instance" do
    should "assign default status when it is created" do
      UserSession.create(users(:admin))

      task = Task.new
      task.description = 'tes'
      task.feature = features(:one)
      task.project = projects(:projexion)
      task.sprint = sprints(:one)
      task.user = users(:admin)

      assert task.save

      default_status = TaskStatus.find(:first, :conditions => {:default_status => true})
      assert_equal task.task_status, default_status
    end

    should "not be saved without a description" do
      task = Task.new

      assert !task.save
    end
  end
end