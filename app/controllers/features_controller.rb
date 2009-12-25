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
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => @feature.id),
                                  :notice => 'Feature was successfully added.' }
      else
        format.html { render :action => "show" }
      end
    end
  end

  def new
    @feature = Feature.new
    @project = Project.find_by_code(params[:project_id])
  end

  def show
    @feature = Feature.find(params[:id])

    @task = Task.new
    @tasks = @feature.tasks

    @project = @feature.project
    @acceptances = @feature.acceptances
    @task_statuses = TaskStatus.find(:all)
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
  end

  def update
    @feature = Feature.find(params[:id])

    # Let's get the object
    unless params[:feature][:sprint].empty?
      params[:feature][:sprint] = Sprint.find(params[:feature][:sprint])
    else
      params[:feature][:sprint] = nil
    end

    unless params[:feature][:release].empty?
      params[:feature][:release] = Release.find(params[:feature][:release])
    else
      params[:feature][:release] = nil
    end

    respond_with(@feature) do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => @feature.id),
                                  :notice => 'Feature was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @feature = Feature.find(params[:id])

    @feature.destroy

    respond_to do |format|
      flash[:notice] = 'Feature was successfully deleted.'
      format.html { redirect_to project_path(:code => params[:project_id]) }
    end
  end

  #Ajax actions
  def update_list

    @project = Project.find(params[:project_id])

    conditions = {:project_id => @project.id}
    if params[:accepted]
      accepted = params[:accepted]

      if accepted.eql?('true') then conditions[:accepted] = true
      elsif accepted.eql?('false') then conditions[:accepted] = false
      else conditions[:accepted] = nil
      end
    end

    @features = Feature.find(:all, :conditions => conditions)

    respond_with(@features, @project) do |format|
      format.html { render :partial => 'list' }      
    end
  end
end