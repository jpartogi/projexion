class EventsController < ApplicationController
  respond_to :html

  def more
    @projects = current_user.projects

    @events = Event.all(:conditions => { :project_id => @projects },  :order => "created_at DESC", :offset => params[:offset], :limit => 10)

  end
end