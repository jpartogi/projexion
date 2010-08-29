Factory.define :priority do |priority|
  priority.display_name 'High'
  priority.color 'blue'
  priority.level 10
end

Factory.define :project do |project|
  project.name 'Projexion'
  project.code 'PR2'
  project.vision 'To be an awesome free Agile project management tool'
end

Factory.define :release do |release|
  release.version_number '1.0.0'
  release.project Factory.stub(:project)
end

Factory.define :sprint do |sprint|
  sprint.start_date Time.now - 2.days
  sprint.end_date Time.now + 12.days
  sprint.release Factory.stub(:release)
  sprint.project Factory.stub(:project)
end
