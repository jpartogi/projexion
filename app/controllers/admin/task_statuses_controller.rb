class Admin::TaskStatusesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @task_statuses = @current_account.task_statuses.asc(:position)
  end

  def show
    @task_status = TaskStatus.find(params[:id])
  end

  def edit
    @task_status = TaskStatus.find(params[:id])
  end

  def update
    @task_status = TaskStatus.find(params[:id])

    respond_with(@task_status) do |format|
      if @task_status.update_attributes(params[:task_status])
        format.html { redirect_to admin_task_status_path(@task_status), :notice => 'Task status was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @task_status = TaskStatus.find(params[:id])

    @task_status.destroy

    respond_to do |format|
      format.html { redirect_to admin_task_statuses_path, :notice => 'Task status was successfully deleted.' }
    end
  end

  def new
    @task_status = TaskStatus.new
  end

  def create
    @task_status = TaskStatus.new(params[:task_status])

    respond_with(@task_status) do |format|
      if @task_status.save
        format.html { redirect_to admin_task_status_path(@task_status), :notice => 'Task status was successfully added.' }
      else
        format.html { render :action => :new }
      end
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