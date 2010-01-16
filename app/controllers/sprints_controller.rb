class SprintsController < ApplicationController
  layout 'main'
  respond_to :html, :json

  after_filter :generate_velocities, :only => :show

  def create
    @sprint = Sprint.new(params[:sprint])
    @project = Project.find_by_code(params[:project_id])
    @sprint.project = @project

    respond_to do |format|
      if @sprint.save
        flash[:notice] = 'Sprint was successfully added.'
        format.html { redirect_to project_sprints_path(params[:project_id]) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def new
    @project = Project.find_by_code(params[:project_id])
    
    @sprint = Sprint.new # For the form
  end

  def edit
  end

  def update
  end

  # Sprint is soft deleted a.k.a cancelled
  def destroy
  end

  def show
    @sprint = Sprint.find(params[:id])

    @project = @sprint.project
    @features = @sprint.features
  end

  def index
    @project = Project.find_by_code(params[:project_id])
    
    @sprints = @project.sprints
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

    if params[:sprint]
      @sprint = Sprint.find(params[:sprint][:id])
    else
      @sprint = Sprint.new
    end

    @features = @sprint.features
  end

  def burndown
    @project = Project.find_by_code(params[:project_id])

    @plots = TaskDaily.plots(:conditions => { :project_code => params[:project_id] })

    respond_with(@plots) do |format|
      format.html
      format.json { render :json => @plots }
    end
  end
end
