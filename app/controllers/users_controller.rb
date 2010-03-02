class UsersController < ApplicationController
  respond_to :html, :json
  before_filter :require_user, :except => [:new, :create]
  
  def index
    @users = User.all
    render :layout => "main" 
  end

  def show
    @user = User.find(params[:id])
    render :layout => "main" 
  end

  def new
    @user = User.new
  end

  def edit
  	#TODO: Check if it is current user, otherwise redirect
    @user = User.find(params[:id])
    render :layout => "main" 
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to root_path }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
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

  #TODO: Only admin are allowed to do this
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end
