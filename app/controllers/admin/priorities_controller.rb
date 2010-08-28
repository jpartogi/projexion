class Admin::PrioritiesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /admin_priorities
  # GET /admin_priorities.xml
  def index
    @priorities = Priority.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @priorities }
    end
  end

  # GET /admin_priorities/1
  # GET /admin_priorities/1.xml
  def show
    @priority = Priority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @priority }
    end
  end

  # GET /admin_priorities/new
  # GET /admin_priorities/new.xml
  def new
    @priority = Priority.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @priority }
    end
  end

  # GET /admin_priorities/1/edit
  def edit
    @priority = Priority.find(params[:id])
  end

  # POST /admin_priorities
  # POST /admin_priorities.xml
  def create
    @priority = Priority.new(params[:priority])

    respond_to do |format|
      if @priority.save
        format.html { redirect_to( admin_priority_path(@priority), :notice => 'Priority was successfully created.') }
        format.xml  { render :xml => @priority, :status => :created, :location => @priority }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_priorities/1
  # PUT /admin_priorities/1.xml
  def update
    @priority = Priority.find(params[:id])

    respond_to do |format|
      if @priority.update_attributes(params[:priority])
        format.html { redirect_to( admin_priority_path(@priority), :notice => 'Priority was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_priorities/1
  # DELETE /admin_priorities/1.xml
  def destroy
    @priority = Priority.find(params[:id])
    @priority.destroy

    respond_to do |format|
      format.html { redirect_to(admin_priorities_url, :notice => 'Priority was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
