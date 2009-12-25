class Event < ActiveRecord::Base
    # Class methods
  class << self
    def add(action, model_class, model_id)
      event = Event.new
      event.action = action
      event.model = model_class
      event.model_id = model_id
      event.save
    end   
  end
end