# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

project = Project.create(:name => 'Projexion', :code => 'PR', :vision => 'To be the best Scrum project management tool')

release = Release.create(:version_number => '0.9.0', :estimate_date => '2010-03-01', :project => project)

sprint = Sprint.create(:start_date => "2009-12-14", :end_date => "2009-12-27", :goal => "Create demonstrable product", :project => project)

feature = Feature.create(:user_story => 'As a team member I want to be able create new feature',
               :business_value => 1000,
               :story_points => 5,
               :priority => 1,
               :acceptance_test => 'Team member should be able to insert new feature',
               :project => project,
               :release => release,
               :sprint => sprint)

task_status = TaskStatus.create(:display_name => 'Pooled',
                                :key => 'pooled',
                                :default_status => true,
                                :color => '002aa2')

TaskStatus.create(:display_name => 'In Progress',
                                :key => 'in-progress',
                                :default_status => false,
                                :color => 'cb0000')

TaskStatus.create(:display_name => 'Done',
                                :key => 'done',
                                :default_status => false,
                                :color => '228200')

task = Task.create(:description => 'Create scaffolding for feature',
                   :feature => feature,
                   :task_status => task_status)
