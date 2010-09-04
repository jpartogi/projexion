class Admin::UsersController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @users = @current_account.users
  end
  
  def show
  	@user = User.find(params[:id])
  	
  	@project_members = @user.project_members
  end
  
  def new
  	@user = User.new
  end
  
  def edit
  	@user = User.find(params[:id])
  end
  
  def create
	@user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end  
  end
  
  def update
  	@user = User.find(params[:id])

    respond_with(@user) do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), :notice => 'User was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end 	
  end
  
  def destroy
  	@user = User.find(params[:id])
  	@project_members = @user.project_members

  	@user.destroy
    ProjectMember.destroy(@project_members)
  	
  	respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => 'User was successfully deleted.' }
    end	
  end

  def deactivate
    @user = User.find(params[:id])
  end
end 