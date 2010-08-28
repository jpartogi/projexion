class ProjectsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def index
    @projects = @current_account.projects
  end

  def show
    @project = @current_account.projects.find_or_initialize_by(:code => params[:id]) || @current_account.projects.find(params[:id])

    @manager = @project.manager

    @releases = @project.active_releases

    @sprints = @project.active_sprints

    @features = @project.features
    @sprint = @project.current_sprint
    @features = @features.where(:sprint_id => @sprint)
  end

end
