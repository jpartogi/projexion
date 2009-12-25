class TasksController < ApplicationController
  
  def create
    @task = Task.new(params[:task])
    @feature = Feature.find(params[:feature_id])
    @project = @feature.project

    @task.feature = @feature
    @task.project = @project

    respond_with(@task) do |format|
      if @task.save
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]),
                                  :notice => 'Task was successfully added.' }
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
  def update_desc
    @task = Task.find(params[:id])

    @task.description = params[:value]
    
    respond_with(@task) do |format|
      if @task.save
        format.json { render :json => @task }
      else
        format.json  { render :json => @task.errors, :status => :unprocessable_entity }
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
