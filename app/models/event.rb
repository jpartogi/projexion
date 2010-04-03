class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :audits

  # Class methods
  class << self
    def add(action, model_class, project)
      event = Event.new
      event.action = action
      event.model = model_class
      event.project = project
      event.user = UserSession.current_user
      event.save

      event
    end   
  end
end