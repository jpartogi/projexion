Factory.define :user do |user|
  user.email 'blah@example.com'
  user.password 'password'
#  user.association :plan, :factory => :plan
end

Factory.define :account do |account|
  account.subdomain 'scrum8'

  account.association :owner, :factory => :user
end

Factory.define :priority do |priority|
  priority.display_name 'Low'
  priority.color 'ccc'
  priority.level 10
end

Factory.define :project do |project|
  project.name 'Projexion'
  project.vision 'To be the best Scrum software'

  project.association :account, :factory => :account
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