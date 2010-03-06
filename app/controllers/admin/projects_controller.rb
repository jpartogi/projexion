class Admin::ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find_by_code(params[:id])
  end

  def create
    @project = Project.new(params[:project])

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

    respond_with(@project) do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to project_path(@project.code), :notice => 'Project was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end