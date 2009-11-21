class ReleasesController < ApplicationController
  layout 'main'
  respond_to :html, :json
  
  def create
    @release = Release.new(params[:release])
    @project = Project.find_by_code(params[:project_id])
    @release.project = @project

    respond_to do |format|
      if @release.save
        flash[:notice] = 'Task was successfully added.'
        format.html { redirect_to project_releases_path(params[:project_id]) }
      else
        format.html { render :action => "new" }   
      end
    end
  end

  def new
    @project = Project.find_by_code(params[:project_id])
    
    @release = Release.new # For the form    
  end

  def edit
  end

  def update
  end

  def destroy
    @release = Release.find(params[:id])

    @release.destroy

    respond_to do |format|
      format.html { redirect_to project_releases_path(:code => params[:project_id]) }
      format.json  { head :ok }
    end
  end

  def show
  end

  def index
    @project = Project.find_by_code(params[:project_id])

    @releases = @project.releases

    respond_with(@project, @releases)
  end

end
