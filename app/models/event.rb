class Event < ActiveRecord::Base
  belongs_to :project, :primary_key => :code, :foreign_key => :project_code

  # Class methods
  class << self
    def add(action, model_class, model_id, project)
      event = Event.new
      event.action = action
      event.model = model_class
      event.model_id = model_id
      event.project = project
      event.save
    end   
  end
end