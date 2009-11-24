class TasksController < ApplicationController
  respond_to :html, :json

  def create
    @task = Task.new(params[:task])
    @feature = Feature.find(params[:feature_id])

    @task.feature = @feature
    
    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully added.'
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]) }
      else
        format.html { render :action => "show", :controller => "feature" }
        format.json  { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @feature = Feature.find(params[:feature_id])
    @project = @feature.project
    
    @task = Task.new

    respond_with(@task, @feature, @project) do |format|
      format.json { render  }
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
      flash[:notice] = 'Task was successfully deleted.'
      format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]) }
      format.xml  { head :ok }
    end
  end

  # Ajax update of task description
  def update_desc
    @task = Task.find(params[:id])

    @task.description = params[:desc]
    
    respond_with(@task) do |format|
      if @task.save
        format.json { render :json => @task }
      else
        format.json  { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end
end
