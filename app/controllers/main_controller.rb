class MainController < ApplicationController
    respond_to :html, :json
    before_filter :require_user, :only => :index

    def index
      @projects = current_user.projects

      @events = Event.find(:all, :conditions => { :project_id => @projects },  :order => "created_at DESC")

      @meetings = Meeting.find(:all, :conditions => ["start_time > ? and project_id in (?)", Time.now, @projects])
    end
end
