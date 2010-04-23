class MainController < ApplicationController
    respond_to :html, :json
    before_filter :require_user, :only => :index

    caches_page :index 

    def index
      @projects = current_user.projects

      params[:next_offset] = 11
      #Events initial list only. The rest is fetched using ajax on EventsController
      @events = Event.includes(:audits).where(:project_id => @projects).order("events.created_at DESC").limit(10)

      # TODO: Limit this. Use batch?
      @meetings = Meeting.includes(:project, :meeting_type).where(["start_time > ? and project_id in (?)", Time.now, @projects])
                    .order('meetings.start_time')

      # TODO: Limit this. 
      @tasks = Task.includes(:feature, :project).where(:user_id => current_user)
    end
end
