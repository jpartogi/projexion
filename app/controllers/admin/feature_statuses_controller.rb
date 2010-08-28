class Admin::FeatureStatusesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @feature_statuses = FeatureStatus.all(:order => "position")
  end

  def show
    @feature_status = FeatureStatus.find(params[:id])
  end

  def edit
    @feature_status = FeatureStatus.find(params[:id])
  end

  def update
    @feature_status = FeatureStatus.find(params[:id])

    respond_with(@feature_status) do |format|
      if @feature_status.update_attributes(params[:feature_status])
        format.html { redirect_to admin_feature_status_path(@feature_status), :notice => 'Feature status was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @feature_status = FeatureStatus.find(params[:id])

    @feature_status.destroy

    respond_to do |format|
      format.html { redirect_to admin_feature_statuses_path, :notice => 'Feature status was successfully deleted.' }
    end
  end

  def new
    @feature_status = FeatureStatus.new
  end

  def create
    @feature_status = FeatureStatus.new(params[:feature_status])

    respond_with(@feature_status) do |format|
      if @feature_status.save
        format.html { redirect_to admin_feature_status_path(@feature_status), :notice => 'Feature status was successfully added.' }
      else
        format.html { render :action => :new }
      end
    end
  end

  def update_position
    @feature_status = FeatureStatus.find(params[:id])
    
    @feature_status.update_position(params[:direction])

    @feature_statuses = FeatureStatus.all(:order => "position")

    respond_with(@feature_statuses) do |format|
      format.html { render :partial => 'list' }
    end
  end
end