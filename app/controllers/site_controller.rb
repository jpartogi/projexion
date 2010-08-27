class SiteController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  
  def index
    
  end
end