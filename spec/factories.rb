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