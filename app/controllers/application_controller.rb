# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # helper :all # include all helpers, all the time
  include UrlHelper
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_current_account

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  private
    def set_current_account
      unless request.subdomains.empty?
        @current_account = Account.find_by_subdomain!(request.subdomains.first)
      end
    end
end
