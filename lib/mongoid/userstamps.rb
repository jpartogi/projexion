module Mongoid
  module Userstamps
    extend ActiveSupport::Concern

    included do
      referenced_in :creator, :class_name => 'User'
      referenced_in :updater, :class_name => 'User'
    end

  end
end  