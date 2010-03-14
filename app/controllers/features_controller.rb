class FeaturesController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  
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

  #TODO: Functional test
  def index
    @feature = Feature.new(params[:feature]) || Feature.new # for search

    @project = Project.find_by_code(params[:project_id])
    @sprints = Sprint.find_all_by_project_id(@project, :order => 'start_date desc')
    @releases = Release.find_all_by_project_id(@project)

    @features = @project.features
    if params[:feature]
      conditions = params[:feature]

      unless conditions[:user_story].empty?
        @features = @features.where(['user_story like ?', '%'+conditions[:user_story]+'%'])
      end

      unless conditions[:sprint_id].empty?
        @features = @features.where(['sprint_id = ?', conditions[:sprint_id]])
      end

      unless conditions[:release_id].empty?
        @features = @features.where(['release_id = ?', conditions[:release_id]])
      end

    end

    #In the end we need to paginate it.
    @features = @features.paginate(:page => params[:page], :order => 'id DESC', :per_page =>20)
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

    @project = Project.find_by_code(params[:id])

    conditions = Hash.new
    conditions[:project_id] = @project
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

  def update_status
    @feature = Feature.find(params[:id])
    @feature_status = FeatureStatus.find(params[:status_id])

    @feature.feature_status = @feature_status

    respond_with(@feature, @feature_status) do |format|
      if @feature.save
        format.json { render :json => {:feature => @feature, :feature_status => @feature_status} }
      else
        format.json  { render :json => @feature_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_sprint
    @sprint = Sprint.find(params[:id])
    @feature = Feature.find(params[:parent_id])
    @feature.sprint = @sprint
    @project = @feature.project

    respond_to do |format|
      if @feature.save
        format.html { render :partial => 'sprints/label' }
      end
    end
  end

  def update_release
    @release = Release.find(params[:id])
    @feature = Feature.find(params[:parent_id])
    @feature.release = @release
    @project = @feature.project

    respond_to do |format|
      if @feature.save
        format.html { render :partial => 'releases/label' }
      end
    end
  end
end