class FeatureObserver < ActiveRecord::Observer
  def after_save(feature)

    changes = feature.changed

    event = add_event(feature)
    changes.each do |change|

      change_attr = change + '_change'
      values = feature.send(change_attr)

      audit = Audit.new
      audit.changed_field = change
      audit.old_value = values[0]
      audit.new_value = values[1]
      audit.model = feature.class.to_s
      audit.model_id = feature.id
      audit.project = feature.project
      audit.user = UserSession.current_user
      audit.event = event
      
      audit.save

    end

  end

  def add_event(feature)
    if feature.new_record?
      event = 'created'
    else
      event = 'modified'
    end

    event = Event.add event, feature.class.to_s, feature.project
  end
end