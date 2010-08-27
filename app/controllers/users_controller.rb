class UsersController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, :except => [:new, :create, :edit, :update]

  def index
    @users = User.all
    render :layout => "main" 
  end

  def show
    @user = User.find_by_login(params[:id])

    @tasks = @user.tasks

    @project_members = @user.project_members
    
    render :layout => "main" 
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_or_initialize_by(:id => params[:id])

    #authorize! @user

    render :layout => "site" 
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to edit_user_path(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def change_password
    @user = User.find(params[:id])
    render :layout => "main"
  end
end
