class Release < ActiveRecord::Base
  belongs_to :project, :primary_key => :code, :foreign_key => :project_code
  has_many :features
  
  validates_presence_of :version_number

  #TODO: Create release notes on released
end
