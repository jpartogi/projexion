class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content

  referenced_in :account
  referenced_in :project
  referenced_in :user

  # Class methods
  class << self
    def add(action, model_class, model_id, project)
      event = Event.new
      event.action = action
      event.model = model_class
      event.model_id = model_id
      event.project = project
      event.user = UserSession.current_user
      event.save

      event
    end   
  end
end