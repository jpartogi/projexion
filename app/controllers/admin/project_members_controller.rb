class Admin::ProjectMembersController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  #load_and_authorize_resource
  
  def new
    @project_member = ProjectMember.new
    
    @project_roles = @current_account.project_roles
    @projects = @current_account.projects
    @users = @current_account.users
  end

  def create
    @project_member = ProjectMember.new
    
    @user = User.find(params[:project_member][:user_id])
    @project = Project.find(params[:project_member][:project])
    @project_role = ProjectRole.find(params[:project_member][:project_role])

    @project_member.user = @user
    @project_member.project_role = @project_role
    @project_member.status = ProjectMember::ACTIVE

    @project.users << @user
    @project.project_members << @project_member

    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to admin_user_path(params[:project_member][:user_id]), :notice => 'User was successfully updated.' }
      else
        format.html { render :new }
      end
    end
  end

  #Ajax actions
  def update_role
    @project_member = ProjectMember.find(params[:parent_id])
    @project_role = ProjectRole.find(params[:id])

    @project_member.project_role = @project_role

    respond_to do |format|
      if @project_member.save
        format.html { render :partial => 'project_roles/label' }
      end
    end
  end
end