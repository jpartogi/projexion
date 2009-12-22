class FeaturesController < ApplicationController
  layout 'main'
  respond_to :html, :json
  
  def create
    @feature = Feature.new(params[:feature])
    @project = Project.find_by_code(params[:project_id])
    @feature.project = @project
    @feature.acceptances = Acceptance.to_a(params[:acceptance_test])
    
    respond_with(@feature) do |format|
      if @feature.save_all
        flash[:notice] = 'Feature was successfully added.'
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => @feature.id) }
        format.xml  { render :xml => @feature, :status => :created, :location => @feature }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @feature = Feature.new
    @project = Project.find_by_code(params[:project_id])
    respond_with(@feature, @project)
  end

  def show
    @feature = Feature.find(params[:id])

    @task = Task.new
    @tasks = @feature.tasks

    @project = @feature.project
    @acceptances = @feature.acceptances
    @task_statuses = TaskStatus.find(:all)

    respond_with(@project, @feature, @tasks, @task_statuses, @acceptances)
  end

  def index
    if params[:release_id]
      @release  = Release.find(params[:release_id])
      @features = @release.features
      @project = @release.project
    elsif params[:sprint_id]
      @sprint = Sprint.find(params[:sprint_id])
      @features = @sprint.features
      @project = @sprint.project
    else
      @features = Feature.find(:all)
    end

    respond_with(@features)
  end

  def edit
    @feature = Feature.find(params[:id])
    @project = Project.find_by_code(params[:project_id])

    @sprints = @project.sprints.reject do |sprint|
      sprint.end_date < Date.today
    end

    @releases = @project.releases.reject do |release|
      release.released == true  
    end
    
    respond_with(@feature, @project, @sprints, @releases)
  end

  def update
    @feature = Feature.find(params[:id])

    # Let's get the object
    params[:feature][:sprint] = Sprint.find(params[:feature][:sprint]) 
    params[:feature][:release] = Release.find(params[:feature][:release])

    respond_with(@feature) do |format|
      if @feature.update_attributes(params[:feature])
        flash[:notice] = 'Feature was successfully updated.'
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => @feature.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @feature = Feature.find(params[:id])

    @feature.destroy

    respond_to do |format|
      flash[:notice] = 'Feature was successfully deleted.'
      format.html { redirect_to project_path(:code => params[:project_id]) }
      format.xml  { head :ok }
    end
  end

end
