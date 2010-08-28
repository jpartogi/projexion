class Admin::ProjectsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def index

  end

  def show
    @project = Project.find_or_initialize_by(:code => params[:id])
  end

  def new
    @project = Project.new
    #authorize! :create, @project
  end

  def edit
    @project = Project.find(params[:id])
    unauthorized! if cannot? :edit, @project
  end

  def create
    @project = Project.new(params[:project])
    @project.account = @current_account
    #authorize! :create, @project
    
    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to project_path(@project.code), :notice => 'Project was successfully added.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @project = Project.find(params[:id])
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

  def add_user
    @project = Project.find_or_initialize_by(:code => params[:id])
    @users = @current_account.users
  end

  def save_user
    @project = Project.find(params[:id])
    @project.users << User.find(params[:project][:users])
    puts User.find(params[:project][:users])
    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_project_path(@project.code), :notice => 'User was successfully added.' }  
      else
        format.html { render :add_user }
      end
    end
  end
end