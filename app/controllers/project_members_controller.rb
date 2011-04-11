class ProjectMembersController < ApplicationController
  respond_to :html, :json, :js
  before_filter :authenticate_user!

  def new
    @project = @current_account.projects.where(:code => params[:project_id]).first

    @project_member = ProjectMember.new
    @users = @current_account.users
    @project_roles = @current_account.project_roles
    
    render :layout => false  
  end

  def create
    @project = @current_account.projects.where(:code => params[:project_id]).first

    @user = @current_account.users.find(params[:project_member][:user_id])
    @project_role = @current_account.project_roles.find(params[:project_member][:project_role_id])

    @user.projects << @project

    @users = @current_account.users
    @project_roles = @current_account.project_roles

    @project_member = ProjectMember.new(params[:project_member])
    @project_member.project = @project
    @project_member.user = @user
    @project_member.project_role = @project_role
    
    respond_to do |format|
      if @project_member.save
        format.html { redirect_to project_project_member_path(@project, @project_member) } #Not used. To make test pass
        format.json
        format.js
      else
        format.html { render :action => :new }
        format.json
        format.js
      end
    end
  end
end