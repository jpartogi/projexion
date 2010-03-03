class Admin::UsersController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user
  
  def index
    @users = User.all
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
  	
  	@user.destroy
  	
  	respond_to do |format|
      format.html { redirect_to admin_user_path, :notice => 'User status was successfully deleted.' }
    end	
  end
end 