require 'test_helper'
require 'shoulda'

class TaskTest < ActiveSupport::TestCase
  fixtures :all
  
  context "A Task instance" do
    should "assign default status when it is created" do
      task = Task.new
      task.description = 'tes'
      task.feature_id = 1
      task.project_id = 1

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