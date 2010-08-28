class ProjectRole
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :manager, :type => Boolean
  field :role

  references_many :project_member
  referenced_in :account

#  belongs_to :project_member
#
#  before_save :check_and_update_manager
#
#  validates_presence_of :name
#
#  def check_and_update_manager
#    manager = ProjectRole.manager
#
#    unless manager.nil?
#      if self.manager
#        manager.manager = false
#        manager.save
#      end
#    end
#  end
#
  class << self
    def manager
      self.first(:conditions => {:manager => true})
    end
  end
end