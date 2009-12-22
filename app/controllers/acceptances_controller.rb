class AcceptanceController < ApplicationController

  def destroy
    @acceptance = Acceptance.find(params[:id])

    @acceptance.destroy

    respond_to do |format|
      flash[:notice] = 'Acceptance test was successfully deleted.'
      format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]) }
    end
  end

  # Ajax actions
  def update_acceptance
    @acceptance = Acceptance.find(params[:acceptance_id])

    @acceptance.accepted = !@acceptance.accepted

    respond_with(@acceptance) do |format|
      if @acceptance.save
        format.json { render :json => @acceptance }
      end
    end
  end
end