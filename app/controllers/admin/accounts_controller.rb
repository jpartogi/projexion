class Admin::AccountsController < ApplicationController

  def update
    respond_to do |format|
      if @current_account.update_attributes(params[:account])
        format.html { redirect_to admin_path, :notice => 'Account was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end
  
end