class MainController < ApplicationController
    respond_to :html, :json
    before_filter :require_user, :only => :index

    def index
      @projects = current_user.projects

      @events = Event.find(:all, :conditions => { :project_id => @projects },  :order => "created_at DESC")
    end
end
