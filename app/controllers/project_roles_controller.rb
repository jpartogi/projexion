class ProjectRolesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  
  # Ajax actions
  def get_options
    @project_member = ProjectMember.find(params[:parent_id])

    @project_roles = @current_account.project_roles

    respond_with(@project_roles) do |format|
      format.html { render :partial => 'options' }
    end
  end
end