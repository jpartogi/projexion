class ProjectMembersController < ApplicationController
  respond_to :html
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
    @users = @current_account.users
    @project_roles = @current_account.project_roles

    @project_member = ProjectMember.new(params[:project_member])
    @project_member.project = @project
    
    respond_to do |format|
      if @project_member.save
        format.html
        format.js
      else
        format.html { render :action => :new }
      end
    end
  end
end