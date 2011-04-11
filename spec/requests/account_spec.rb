require 'spec_helper'

describe "accounts request" do
  before :each do
    @host= 'http://projexion.dev/'
    get @host
  end

  it "creates accounts" do
    post accounts_path, { :account => {:company => {:name => 'Foo'}, :subdomain => 'foo',
                                 :users => { :username => 'foo', :full_name => 'Foo', :password => 'foofoo', :email => 'foo@foo.com'} } }

    request.should redirect_to 'http://foo.projexion.dev'
  end
end