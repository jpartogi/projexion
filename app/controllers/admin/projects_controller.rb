class Admin::ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  
  def new
    @project = Project.new
    unauthorized! if cannot? :create, @project
  end

  def edit
    @project = Project.find_by_code(params[:id])
    unauthorized! if cannot? :edit, @project
  end

  def create
    @project = Project.new(params[:project])
    unauthorized! if cannot? :create, @project
    
    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to project_path(@project.code), :notice => 'Project was successfully added.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @project = Project.find_by_code(params[:id])
    unauthorized! if cannot? :update, @project

    respond_with(@project) do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to project_path(@project.code), :notice => 'Project was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @project = Project.find_by_code(params[:id])

    @project.destroy

    respond_to do |format|
      format.html { redirect_to admin_path, :notice => 'Project was successfully deleted.' }
    end
  end
end