class MeetingsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def index
    @project = @current_account.projects.find_or_initialize_by(:code => params[:project_id])

    @meetings = @project.meetings.desc(:start_time)
  end

  def show
    @meeting = Meeting.find(params[:id])

    @project = @meeting.project
  end

  def edit
    @meeting = Meeting.find(params[:id])

    @project = @meeting.project

    @meeting_types = @current_account.meeting_types
  end

  def update
    @meeting = Meeting.find(params[:id])

    @project = @meeting.project

    respond_with(@meeting) do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to project_meeting_path(@project.code, @meeting),
                                  :notice => 'Meeting was successfully updated.' }
      else
        format.html { render :action => :edit }
      end
    end
  end

  def new
    @project = @current_account.projects.find_or_initialize_by(:code => params[:project_id])

    @meeting = Meeting.new

    @meeting_types = @current_account.meeting_types
  end

  def create
    @meeting = Meeting.new(params[:meeting])

    @project = @current_account.projects.find_or_initialize_by(:code => params[:project_id])

    @sprint = Sprint.first(:conditions => {:start_date.lt => @meeting.start_time, :end_date.gt => @meeting.end_time, :project_id => @project.id})
    
    @meeting.project = @project
    @meeting.sprint = @sprint

    @meeting_types = @current_account.meeting_types
    
    respond_with(@meeting) do |format|
      if @meeting.save
        format.html { redirect_to project_meeting_path(params[:project_id], @meeting),
                                  :notice => 'Meeting was successfully added.' }
      else
        format.html { render :action => :new }
      end
    end
  end

  # Meeting is cancelled not deleted
  def destroy    
  end

  def cancel
    @meeting = Meeting.find(params[:id])

    @project = @meeting.project

    @meeting.cancelled_at = Date.today

    respond_with(@meeting) do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to project_meeting_path(@project.code, @meeting),
                                  :notice => 'Meeting was successfully cancelled.' }
      else
        format.html { render :action => :edit }
      end
    end
  end
end