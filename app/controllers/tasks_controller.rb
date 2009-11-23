class TasksController < ApplicationController
  layout 'main'
  respond_to :json, :xml, :html 

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
        #format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
        format.json  { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @task = Task.new
    respond_with(@task)
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
