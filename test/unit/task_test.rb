require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "saving new task" do
    task = Task.new
    task.description ='tes'

    assert task.save
    assert_equal Task::STATUS[:pooled], task.status
  end

  test "saving task without description" do
    task = Task.new
    
    assert !task.save
  end

  test "update pooled task to in-progress" do
    task = Task.find(1)
    #puts task.status

    assert task.save
  end
end
