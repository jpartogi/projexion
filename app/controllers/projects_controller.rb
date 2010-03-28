class ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  #load_and_authorize_resource
  
  def index
    @projects = Project.find(:all)
  end
  #TODO: Functional test
  def show
    @project = Project.find_by_code(params[:id])

    @manager = @project.manager

    @releases = @project.active_releases

    @sprints = @project.active_sprints

    @features = @project.features
    @sprint = @project.current_sprint
    @features = @features.where(["sprint_id in (?)", @sprint])
  end

end
