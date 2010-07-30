class Ability
  include CanCan::Ability

  def initialize(user)
#    if user.admin?
#      can :manage, :all
#    else
#      cannot :manage, [:feature_status, :meeting_type, :project_member, :project_role, :task_status]
#    end
  end

end