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
    @project = Project.find_by_code(params[:project_id])
    @features = @project.features
  end

  def edit
    @feature = Feature.find(params[:id])
    @project = @feature.project

    @sprints = @project.active_sprints

    @releases = @project.active_releases
  end

  def update
    @feature = Feature.find(params[:id])

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
      format.html { redirect_to project_path(params[:project_id]),
                                :notice => 'Feature was successfully deleted.' }
    end
  end

  #Ajax actions
  def list

    @project = Project.find_by_code(params[:project_id])

    conditions = Hash.new
    conditions[:project_code] = @project.code
    if params[:accepted]
      accepted = params[:accepted]

      if accepted.eql?('true') then conditions[:accepted] = true
      elsif accepted.eql?('false') then conditions[:accepted] = false
      end
    end

    @features = Feature.find(:all, :conditions => conditions)

    respond_with(@features) do |format|
      format.html { render :partial => 'list' }      
    end
  end

  def accept
    @feature = Feature.find(params[:id])

    @feature.accepted = !@feature.accepted

    respond_with(@feature) do |format|
      if @feature.save
        format.json { render :json => @feature }
      end
    end
  end
end