class AcceptanceController < ApplicationController

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