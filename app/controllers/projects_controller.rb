class ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user

  caches_page :show
  caches_action :show

  def index
    @projects = Project.find(:all)
  end

  def show
    @project = Project.find_by_code(params[:id]) || Project.find(params[:id])

    @manager = @project.manager

    @releases = @project.active_releases

    @sprints = @project.active_sprints

    @features = @project.features
    @sprint = @project.current_sprint
    @features = @features.includes(:sprint, :release, :priority).where(["sprint_id in (?)", @sprint])
  end

end
