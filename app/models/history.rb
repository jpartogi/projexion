class History < ActiveRecord::Base
    # Class methods
  class << self
    def update_history(action, model_class, model_id)
      history = History.new
      history.action = action
      history.model = model_class
      history.model_id = model_id
      history.save
    end   
  end
end