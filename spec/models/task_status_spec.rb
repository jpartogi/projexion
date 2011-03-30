require 'spec_helper'

describe TaskStatus do
  before(:each) do
    User.destroy_all
    Account.destroy_all
    TaskStatus.destroy_all

    @account = Factory.create(:account)
  end

  it "should get ordered status" do
    status = @account.task_statuses.ordered.first

    status.position.should eq(1)

    status = @account.task_statuses.ordered.last

    status.position.should eq(2)
  end
end