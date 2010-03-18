class AdminController < ApplicationController
  layout 'main'
  before_filter :require_user
  load_and_authorize_resource
  
  def index
    @projects = Project.all  
  end
end