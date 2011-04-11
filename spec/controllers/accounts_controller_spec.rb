require 'spec_helper'

describe AccountsController do
  render_views

  it "should create account" do
    post :create, { :account => {:company => {:name => 'Foo'}, :subdomain => 'foo',
                                 :users => { :username => 'foo', :full_name => 'Foo', :password => 'foofoo', :email => 'foo@foo.com'} } }

    assigns(:account).should be_kind_of Account
    assigns(:user).should be_kind_of User
    assigns(:company).should be_kind_of Company
  end
end