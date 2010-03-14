class ReleasesController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  
  def create
    @release = Release.new(params[:release])
    @project = Project.find_by_code(params[:project_id])
    @release.project = @project

    respond_to do |format|
      if @release.save
        flash[:notice] = 'Release was successfully added.'
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
    @release = Release.find(params[:id])

    @project = @release.project
  end

  def update
    @release = Release.find(params[:id])

    @project = @release.project

    respond_with(@release) do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to project_release_path(@project.code, @release),
                                  :notice => 'Release was successfully updated.' }
      else
        format.html { render :action => :edit }
      end
    end
  end

  #Release is soft deleted a.k.a released
  def destroy
  end

  def release
    @release = Release.find(params[:id])
    @project = @release.project
    @release.released_at = Date.today

    respond_with(@release) do |format|
      if @release.save
        format.html { redirect_to project_release_path(@project.code, @release),
                                :notice => 'Release was successfully updated.' }
      end
    end
  end

  def show
    @release = Release.find(params[:id])

    @project = @release.project
    @features = @release.features
  end

  def index
    @project = Project.find_by_code(params[:project_id])

    @releases = @project.releases

    respond_with(@project, @releases)
  end

  # Ajax  actions
  def get_options
    @feature = Feature.find(params[:parent_id])
    @project = @feature.project

    @releases = @project.active_releases

    respond_with(@sprints) do |format|
      format.html { render :partial => 'options' }
    end
  end

end
