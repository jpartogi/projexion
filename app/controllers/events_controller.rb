class EventsController < ApplicationController
  respond_to :html

  def more
    @projects = current_user.projects

    @events = Event.includes(:audits).where(:project_id => @projects).order("events.created_at DESC").limit(10).offset(params[:offset])
  end
end