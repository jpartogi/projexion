class FeaturesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  #TODO: functional test
  def create
    @feature = Feature.new(params[:feature])
    @project = @current_account.projects.find_or_initialize_by(:code => params[:project_id])
    @feature.project = @project
    #@feature.acceptances = Acceptance.to_a(params[:acceptance_test])
    @priorities = Priority.asc(:level)

    @sprints = @project.active_sprints
    @releases = @project.active_releases
    
    respond_with(@feature) do |format|
      if @feature.save
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => @feature.id),
                                  :notice => 'Feature was successfully added.' }
      else
        format.html { render :action => :new }
      end
    end
  end

  def new
    @feature = Feature.new
    @project = @current_account.projects.find_or_initialize_by(:code => params[:project_id])
    @priorities = @current_account.priorities.asc(:level)
    @sprints = @project.active_sprints

    @releases = @project.active_releases
  end

  def show
    @feature = Feature.find(params[:id])

    @task = Task.new
    @tasks = @feature.tasks

    @project = @feature.project
    @acceptances = @feature.acceptances
    @task_statuses = TaskStatus.find(:all)

    @acceptance = Acceptance.new
  end

  #TODO: Functional test
  def index
    @feature = Feature.new(params[:feature]) || Feature.new # for search

    @project = @current_account.projects.find_or_initialize_by(:code => params[:project_id])
    @sprints = @project.sprints.desc(:start_date)
    @releases = @project.releases
    @feature_statuses = @current_account.feature_statuses.asc(:position)
    @priorities = Priority.asc(:level)

    @features = @project.features
    if params[:feature]
      conditions = params[:feature]

      unless conditions[:user_story].empty?
        @features = @features.where(['user_story like ?', '%'+conditions[:user_story]+'%'])
      end

      unless conditions[:sprint_id].empty?
        @features = @features.where({:sprint_id => conditions[:sprint_id]})
      end

      unless conditions[:release_id].empty?
        @features = @features.where({:release_id => conditions[:release_id]})
      end

      unless conditions[:feature_statuses_id].empty?
        @features = @features.where({:feature_status_id => conditions[:feature_status_id]})
      end

      unless conditions[:priority_id].empty?
        @features = @features.where({:priority_id => conditions[:priority_id]})
      end

    end

    # We need to order by priority.level
    #In the end we need to paginate it.
    @features = @features.paginate(:page => params[:page], :per_page =>20)
  end

  def edit
    @feature = Feature.find(params[:id])
    @project = @feature.project

    @sprints = @project.active_sprints

    @releases = @project.active_releases
    @priorities = @current_account.priorities.asc(:level)
  end

  def update
    @feature = Feature.find(params[:id])
    @project = @feature.project

    @sprints = @project.active_sprints

    @releases = @project.active_releases

    @priorities = @current_account.priorities.asc(:level)
    
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
    @feature = Feature.find(params[:parent_id])
    @feature_status = FeatureStatus.find(params[:id])

    @feature.feature_status = @feature_status

    respond_with(@feature, @feature_status) do |format|
      if @feature.save
        format.html { render :partial => 'feature_statuses/label' }
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