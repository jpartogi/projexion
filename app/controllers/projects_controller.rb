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

    sprint_ids = @sprints.map { |sprint| sprint.id }
    @features = @project.features.where(:sprint => sprint_ids)
    @sprint = @project.current_sprint
  end

end
