class ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  
  def index
    @projects = Project.find(:all)
  end

  def show
    @project = Project.find_by_code(params[:id])

    @features = @project.features

    @manager = @project.manager

    @releases = @project.active_releases

    @sprints = @project.active_sprints

    respond_with(@project, @features)
  end

  def destroy
    @project = Project.find(params[:id])

    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_path, :notice => 'Project was successfully deleted.' }
    end
  end

end
