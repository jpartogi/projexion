Factory.define :projexion, :class => Project do |project|
  project.name 'Projexion'
  project.code 'PR2'
  project.vision 'To be an awesome free Agile project management tool'
end

Factory.define :release do |release|
  
end

Factory.define :sprint do |sprint|
  sprint.start_date Date.today - 2.days
  sprint.end_date Date.today + 12.days
  sprint.release Factory.stub(:release)
  sprint.project Factory(:projexion)
end
