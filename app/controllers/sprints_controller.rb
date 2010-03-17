class SprintsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  after_filter :generate_velocities, :only => :show

  def create
    @sprint = Sprint.new(params[:sprint])
    @project = Project.find_by_code(params[:project_id])
    @sprint.project = @project

    respond_with(@sprint) do |format|
      if @sprint.save
        format.html { redirect_to project_sprint_path(params[:project_id], @sprint),
                                  :notice => 'Sprint was successfully added.' }
      else
        format.html { render :action => :new }
      end
    end
  end

  def new
    @project = Project.find_by_code(params[:project_id])
    
    @sprint = Sprint.new # For the form
  end

  def edit
    @sprint = Sprint.find(params[:id])

    @project = @sprint.project
  end

  def update
    @sprint = Sprint.find(params[:id])

    @project = @sprint.project
    
    respond_with(@sprint) do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to project_sprint_path(@project.code, @sprint),
                                  :notice => 'Sprint was successfully updated.' }
      else
        format.html { render :action => :edit }
      end
    end
  end

  # Sprint is soft deleted a.k.a cancelled
  def destroy
  end

  def cancel
    @sprint = Sprint.find(params[:id])

    @project = @sprint.project

    @sprint.cancelled_at = Date.today

    respond_with(@sprint) do |format|
      if @sprint.save
        format.html { redirect_to project_sprint_path(@project.code, @sprint),
                                :notice => 'Sprint was successfully cancelled.' }
      end
    end
  end

  def show
    @sprint = Sprint.find(params[:id])

    @project = @sprint.project
    @features = @sprint.features

    @meetings = Meeting.where({:sprint_id => @sprint})
  end

  def index
    @project = Project.find_by_code(params[:project_id])
    
    @sprints = @project.sprints
    @sprints = @sprints.paginate(:page => params[:page], :order => 'start_date desc', :per_page =>20)
  end

  def generate_velocities
    if Date.today > @sprint.end_date 
      @sprint.generate_velocities
    end
  end

  def taskboard
    @project = Project.find_by_code(params[:project_id])

    @sprints = @project.sprints # For the sprint dropdown selector

    @task_statuses = TaskStatus.find(:all)

    id = params[:id] || params[:sprint][:id]
    @sprint = Sprint.find(id) || Sprint.new

    @task_board = Task.board(:conditions => { :sprint_id => @sprint.id })
    @column_width = (100/(@task_statuses.length + 1)).to_s.concat('%')
  end

  def burndown
    @project = Project.find_by_code(params[:project_id])

    @sprints = @project.sprints # For the sprint dropdown selector
    
    @sprint = Sprint.find(params[:id]) || Sprint.new
    
    @plots = SprintSnapshot.plots(:conditions => { :project_id => @project, :sprint_id => @sprint }, :order => :updated)

    respond_with(@plots) do |format|
      format.html
      format.json { render :json => @plots }
    end
  end

  #Ajax options
  def get_options
    @feature = Feature.find(params[:parent_id])

    @project = @feature.project

    @sprints = @project.active_sprints

    respond_with(@sprints) do |format|
      format.html { render :partial => 'options' }  
    end
  end
end
