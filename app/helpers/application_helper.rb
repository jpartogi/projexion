module ApplicationHelper
  def save_button_tip
    "Save the record"
  end

  def cancel_button_tip
    "Cancel this operation"
  end
  #TODO: Add delete confirmation message

  def options_from_collection_for_select_with_blank(collection, value_method, text_method, selected = nil)
    raw "<option value=''></option>".concat(options_from_collection_for_select(collection, value_method, text_method, selected))
  end
end
