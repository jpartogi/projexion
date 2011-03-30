class TasksController < ApplicationController
  respond_to :html, :json, :js
  before_filter :authenticate_user!
  
  def create
    @task = Task.new(params[:task])
    @feature = Feature.find(params[:feature_id])
    @project = @feature.project

    @task.account = @current_account
    @task.user = current_user
    @task.feature = @feature
    @task.project = @feature.project
    @task.sprint = @feature.sprint

    respond_with(@task) do |format|
      if @task.save
        format.json { render :json => @task }
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]),
                                  :notice => 'Task was successfully added.'}
        format.js
      else
        format.json { render :json => @task.errors, :status => :unprocessable_entity}
        format.html { render :new }
        format.js
      end
    end
  end

  def new
    @feature = Feature.find(params[:feature_id])
    @project = @feature.project
    
    @task = Task.new

    respond_with(@task, @feature, @project) do |format|
      format.html { render }
    end
  end

  def index
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @task = Task.find(params[:id])

    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]),
                                :notice => 'Task was successfully deleted.' }
    end
  end

  # Ajax actions
  def check
    @task = Task.find(params[:id])
    puts @task.done
    @task.done = !@task.done
    puts !@task.done
        
    respond_to do |format|
      if @task.save
        format.js
      end
    end
  end

  def update_desc
    @task = Task.find(params[:id])

    @task.description = params[:value]
    
    respond_with(@task) do |format|
      if @task.save
        format.json { render :json => @task }
      else
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_status
    @task = Task.find(params[:id])
    @task_status = TaskStatus.find(params[:status_id])

    @task.task_status = @task_status

    respond_with(@task, @task_status) do |format|
      if @task.save
        format.json { render :json => {:task => @task, :task_status => @task_status} }
      else
        format.json  { render :json => @task_status.errors, :status => :unprocessable_entity }
      end
    end
  end
end
