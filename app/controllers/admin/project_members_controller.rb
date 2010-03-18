class Admin::ProjectMembersController < ApplicationController
  respond_to :html, :json
  before_filter :require_user
  load_and_authorize_resource
  
  def new
    @project_member = ProjectMember.new

    @project_roles = ProjectRole.all

    @projects = Project.all
  end

  def create
    @project_member = ProjectMember.new(params[:project_member])

    respond_with(@project_member) do |format|
      if @project_member.save
        format.html { redirect_to admin_user_path(@project_member.user), :notice => 'User was successfully updated.' }
      end
    end
  end
end