class Task < ActiveRecord::Base
  STATUS = { :pooled => 'P', :inprogress => 'I', :done => 'D' }

  belongs_to :feature

  validates_presence_of :description
  
  before_create :default_status
  #TODO: Add css_class property
  def default_status
    self[:status]= STATUS[:pooled] if self[:status].nil?
  end
end

