# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # helper :all # include all helpers, all the time
  include UrlHelper
  
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :current_account, :set_current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  rescue_from Projexion::Errors::RecordNotFoundError do |exception|
    render 'shared/errors/404', :layout => false
  end

  private
    def current_account
      unless request.subdomains.empty?
        @current_account = Account.first(:conditions => {:subdomain => request.subdomains.first})
        raise Projexion::Errors::RecordNotFoundError if @current_account.nil?
      end
    end

    def set_current_user
      @current_user = current_user
      @projects = @current_user.projects unless current_user.nil?
    end

  protected
    def parameterize(params)
      result = Array.new
      params.split.each do |param|
        result << /#{param.downcase.gsub('*', '.*')}/
      end
      result
    end
end