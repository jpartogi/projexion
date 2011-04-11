Factory.define :user do |user|
  user.email 'blah@example.com'
  user.password 'password'
#  user.association :plan, :factory => :plan
end

Factory.define :company do |company|
  company.name 'Scrum8'
end

Factory.define :project_role do |project_role|
  project_role.name 'Scrum master'
  project_role.role 'Enforce the Scrum process is running'
end

Factory.define :account do |account|
  account.subdomain 'scrum8'

  account.after_build do |a|
    Factory(:company, :account => a)

    a.users << Factory(:user, :account => a)
    a.owner = a.users.first
    a.feature_statuses << Factory(:feature_status, :account => a)
    a.priorities << Factory(:priority, :account => a)
    a.project_roles << Factory(:project_role, :account => a)
  end
end

Factory.define :priority do |priority|
  priority.name 'Low'
  priority.color 'ccc'
  priority.level 10
end

Factory.define :feature do |feature|
  feature.user_story 'hello'
  feature.business_value 100
  feature.story_points 100
end

Factory.define :project do |project|
  project.code 'projexion'
  project.name 'Projexion'
  project.vision 'To be the best Scrum software'

  project.association :account, :factory => :account

  project.after_build do |p|
    p.releases << Factory(:release, :project => p)
    p.sprints << Factory(:sprint, :project => p, :release => p.releases.first)
    p.features << Factory(:feature, :project => p, :sprint => p.sprints.first,
                          :feature_statuses => p.account.feature_statuses.first,
                          :release => p.releases.first,
                          :priority => p.account.priorities.first)

  end
end

Factory.define :release do |release|
  release.version_number '1.0.0'
end

Factory.define :sprint do |sprint|
  sprint.name '1'
  sprint.start_date Date.new
  sprint.end_date Date.new + 1

end

Factory.define :feature_status do |f|
  f.display_name 'Finish'
  f.key 'finish'
  f.color 'ccc'
end


Factory.define :feature_status_pooled, :class => FeatureStatus do |o|
  o.display_name 'Pooled'
  o.key 'pooled'
  o.color 'blue'
end

Factory.define :feature_status_done, :class => FeatureStatus do |o|
  o.display_name 'Done'
  o.key 'done'
  o.color 'red'
end