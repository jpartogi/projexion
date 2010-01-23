class AdminController < ApplicationController
  layout 'main'
  before_filter :require_user
  
  def index
    
  end
end