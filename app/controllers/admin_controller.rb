class AdminController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @project = Project.new
    @projects = @current_account.projects
  end
end