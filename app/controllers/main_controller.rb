class MainController < ApplicationController
    respond_to :html, :json
    before_filter :require_user, :only => :index

    def index
      @projects = current_user.projects

      params[:next_offset] = 11

      @events = Event.all(:conditions => { :project_id => @projects },  :order => "created_at DESC", :limit => 10)

      @meetings = Meeting.all(:conditions => ["start_time > ? and project_id in (?)", Time.now, @projects], :order => 'start_time')
    end
end
