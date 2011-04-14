class AcceptancesController < ApplicationController
  respond_to :html, :json, :js
  before_filter :authenticate_user!
  
  def new
    @feature = Feature.find(params[:feature_id])
    @project = @feature.project

    @acceptance = Acceptance.new

    respond_with(@acceptance, @feature, @project) do |format|
      format.html { render }
    end
  end

  def create
    @acceptance = Acceptance.new(params[:acceptance])
    @feature = Feature.find(params[:feature_id])

    @acceptance.feature = @feature
    @project = @feature.project

    respond_with(@acceptance) do |format|
      if @acceptance.save
        format.json { render :json => @acceptance }
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]),
                                  :notice => 'Acceptance test was successfully added.' }
        format.js
      else
        format.json { render :json => @acceptance.errors, :status => :unprocessable_entity}
        format.html { render :new }
        format.js
      end
    end
  end

  def destroy
    @project = @current_account.projects.where(:code => params[:project_id]).first
    @feature = @project.features.find(params[:feature_id])
    @acceptance = @feature.acceptances.find(params[:id])

    respond_to do |format|
      if @acceptance.destroy
        format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]),
                                :notice => 'Acceptance test was successfully deleted.' }
        format.js
        format.json
      end
    end
  end

  # Ajax actions
  def check
    @acceptance = Acceptance.find(params[:id])

    @acceptance.accepted = !@acceptance.accepted

    respond_with(@acceptance) do |format|
      if @acceptance.save
        format.js
      end
    end
  end
end