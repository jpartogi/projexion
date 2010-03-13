class TaskStatusesController < ApplicationController
  respond_to :html

  # Ajax actions
  def get_options
    @task = Task.find(params[:task_id])

    @task_statuses = TaskStatus.find(:all)

    respond_with(@task, @task_statuses) do |format|
      format.html { render :partial => 'options' }
    end
  end
end