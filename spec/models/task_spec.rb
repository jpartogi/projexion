require 'spec_helper'

describe Task do
  before(:each) do
    User.destroy_all
    Account.destroy_all
    TaskStatus.destroy_all
    Project.destroy_all
    Priority.destroy_all

    @project = Factory.create(:project)

    @priority = Factory.create(:priority)
  end

  it "should set default status" do
    task = Task.create(:description => 'hello', :account => @project.account, :project => @project)

    task.should_not be nil
    task.task_statuses.should_not be nil
  end
end