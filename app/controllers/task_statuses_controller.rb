class TaskStatusesController < ApplicationController
  layout 'main'
  respond_to :html

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

  # Ajax actions
  def get_options
    @task = Task.find(params[:task_id])

    @task_statuses = TaskStatus.find(:all)

    respond_with(@task, @task_statuses) do |format|
      format.html { render :partial => 'options' }
    end
  end

  def update_position
    id = params[:id]
    direction = params[:direction]
    
    @task_status = TaskStatus.find(id)

    @task_status.update_position(direction)

    @task_statuses = TaskStatus.find(:all, :order => "position")
    
    respond_with(@task_statuses) do |format|
      format.html { render :partial => 'list' }      
    end
  end

end