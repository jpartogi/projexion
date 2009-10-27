class ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  
  def index
    @projects = Project.find(:all)
    respond_with(@projects)
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def create
    @project = Project.new(params[:project])

    respond_with(@project) do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.' 
        format.html { redirect_to :action => "show", :code => @project.code }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @project = Project.find_by_code(params[:code])
    respond_with(@project)
  end

  def edit
    @project = Project.find(params[:id])
    respond_with(@project)
  end

  def update
    @project = Project.find(params[:id])

    respond_with(@project) do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to :action => "show", :code => @project.code }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_path }
      format.xml  { head :ok }
    end
  end

end
