class Admin::UsersController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  
  def index
    @users = User.all
  end
end 