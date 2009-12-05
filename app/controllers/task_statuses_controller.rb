class TaskStatusesController < ApplicationController
  layout 'main'
  respond_to :html, :json

  def index
    @task_statuses = TaskStatus.find(:all, :order => "position")
  end

  def show
    @task_status = TaskStatus.find(params[:id])
  end

  def edit
    
  end

  def update

  end

  def destroy
    @task_status = TaskStatus.find(params[:id])

    @task_status.destroy

    respond_to do |format|
      flash[:notice] = 'Project was successfully deleted.'
      format.html { redirect_to task_statuses_path }
    end
  end

  def new
    @task_status = TaskStatus.new
  end

  def create
    @task_status = TaskStatus.new(params[:task_status])

    flash[:notice] = 'Task status was successfully added.' if @task_status.save

    respond_with(@task_status)
  end

  def update_position
    direction = params[:direction]
    id = params[:id]
    
    @task_status = TaskStatus.find(id)
    
    #TODO: Refactor this to model
    position = @task_status.position

    if direction == 'up'
      status = TaskStatus.find_by_position(position.to_i - 1)
    else
      status = TaskStatus.find_by_position(position.to_i + 1)
    end

    @task_status.position = status.position
    status.position = position

    status.save
    @task_status.save
    
    respond_with(@task_status) do |format|
      if @task_status.save
        format.json { render :json => {:task_status => @task_status} }
      end
    end
  end
end