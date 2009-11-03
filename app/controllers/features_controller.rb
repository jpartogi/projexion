class FeaturesController < ApplicationController
  layout 'main'
  respond_to :html, :json
  
  def create
    @feature = Feature.new(params[:feature])
    @project = Project.find_by_code(params[:project_id])
    @feature.project = @project
    
    respond_with(@feature) do |format|
      if @feature.save
        flash[:notice] = 'Feature was successfully added.'
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => @feature.id) }
        format.xml  { render :xml => @feature, :status => :created, :location => @feature }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @feature = Feature.new
    @project = Project.find_by_code(params[:project_id])
    respond_with(@feature, @project)
  end

  def show
    @feature = Feature.find(params[:id])

    @task = Task.new
    @tasks = @feature.tasks

    @project = @feature.project

    respond_with(@project, @feature, @tasks)
  end

  def index
    @features = Feature.find(:all)
  end

  def edit
    @feature = Feature.find(params[:id])
    @project = Project.find_by_code(params[:project_id])
    respond_with(@feature, @project)
  end

  def update
    @feature = Feature.find(params[:id])

    respond_with(@feature) do |format|
      if @feature.update_attributes(params[:feature])
        flash[:notice] = 'Feature was successfully updated.'
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:id]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @feature = Feature.find(params[:id])

    @feature.destroy

    respond_to do |format|
      format.html { redirect_to project_path(:code => params[:project_id]) }
      format.xml  { head :ok }
    end
  end

end
