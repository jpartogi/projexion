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

  context "Task daily instance" do
    should "update daily sum" do
      assert TaskDaily.sum_daily_tasks

      task_daily = TaskDaily.first(:conditions => {:last_update => Date.today})

      assert task_daily.total_tasks, 2
    end

  end
end