class FeatureStatusesController < ApplicationController
  respond_to :html
  
  # Ajax actions
  def get_options
    @feature = Feature.find(params[:parent_id])

    @feature_statuses = @current_account.feature_statuses.asc(:position)

    respond_with(@feature, @feature_statuses) do |format|
      format.html { render :partial => 'options' }
    end
  end
end