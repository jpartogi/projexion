require 'test_helper'
require 'shoulda'

class TaskTest < ActiveSupport::TestCase
  fixtures :all
  
  context "A Task instance" do
    should "have status as pooled when it is created" do
      task = Task.new
      task.description ='tes'

      assert task.save
      assert_equal Task::STATUS[:pooled], task.status
    end

    should "not be saved without a description" do
      task = Task.new

      assert !task.save
    end
  end

end
