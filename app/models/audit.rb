class Audit < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :event
end