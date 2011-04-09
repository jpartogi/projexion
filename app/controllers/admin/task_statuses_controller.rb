class Admin::TaskStatusesController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @task_status = TaskStatus.new
    @task_statuses = @current_account.task_statuses.asc(:position)
  end

  def show
    @task_status = @current_account.task_statuses.find(params[:id])
  end

  def edit
    @task_status = @current_account.task_statuses.find(params[:id])
  end

  def update
    @task_status = @current_account.task_statuses.find(params[:id])

    respond_with(@task_status) do |format|
      if @task_status.update_attributes(params[:task_status])
        format.html { redirect_to admin_task_status_path(@task_status), :notice => 'Task status was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @task_status = @current_account.task_statuses.find(params[:id])

    respond_to do |format|
      if @task_status.destroy
        format.html { redirect_to admin_task_statuses_path, :notice => 'Task status was successfully deleted.' }
        format.js
        format.json
      else
        format.html
        format.js
        format.json
      end
    end
  end

  def new
    @task_status = TaskStatus.new
  end

  def create
    @task_status = TaskStatus.new(params[:task_status])
    @task_status.account = @current_account

    respond_to do |format|
      if @task_status.save
        format.html { redirect_to admin_task_status_path(@task_status), :notice => 'Task status was successfully added.' }
        format.js
      else
        format.html { render :action => :new }
        format.js
      end
    end
  end

  def update_position
    id = params[:id]
    direction = params[:direction]
    
    @task_status = @current_account.task_statuses.find(id)

    @task_status.update_position(direction)

    @task_statuses = @current_account.task_statuses.find(:all, :order => "position")
    
    respond_with(@task_statuses) do |format|
      format.html { render :partial => 'list' }      
    end
  end

end