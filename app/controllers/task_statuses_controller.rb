class TaskStatusesController < ApplicationController
  layout 'main'
  respond_to :html, :json

  def index
    @task_statuses = TaskStatus.find(:all)
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
end