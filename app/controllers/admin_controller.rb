class AdminController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @projects = Project.all  
  end
end