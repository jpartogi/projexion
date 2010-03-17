class MeetingsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  before_filter :require_user

  def index
    @project = Project.find_by_code(params[:project_id])

    @meetings = Meeting.all(:conditions => { :project_id => @project.id })
  end

  def show
    @meeting = Meeting.find(params[:id])

    @project = @meeting.project
  end

  def edit
    @meeting = Meeting.find(params[:id])

    @project = @meeting.project

    @meeting_types = MeetingType.all
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
    @project = Project.find_by_code(params[:project_id])

    @meeting = Meeting.new

    @meeting_types = MeetingType.all
  end

  def create
    @meeting = Meeting.new(params[:meeting])

    @project = Project.find_by_code(params[:project_id])

    @sprint = Sprint.first(:conditions => ['start_date < ? and end_date > ? and project_id = ?',
                            @meeting.start_time, @meeting.end_time, @project])

    #TODO: Send email to project members
    
    @meeting.project = @project
    @meeting.sprint = @sprint

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