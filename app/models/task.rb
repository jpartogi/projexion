class Task < ActiveRecord::Base
  STATUS = { :pooled => 'P', :inprogress => 'I', :done => 'D' }

  belongs_to :feature
  has_many :task_statuses

  validates_presence_of :description
  
  before_create :default_status
  
  def default_status
    self[:status]= STATUS[:pooled] if self[:status].nil?
  end
end

