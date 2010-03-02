# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

project = Project.create(:code => 'PR', :name => 'Projexion', :vision => 'To be the best Scrum project management tool')

release = Release.create(:version_number => '0.9.0', :estimate_date => '2010-03-01', :project => project)

sprint = Sprint.create(:start_date => "2009-12-14", :end_date => "2009-12-27", :goal => "Create demonstrable product", :project => project)

feature = Feature.create(:user_story => 'As a team member I want to be able create new feature',
               :business_value => 1000,
               :story_points => 5,
               :priority => 1,
               :project => project,
               :release => release,
               :sprint => sprint)

Acceptance.create(:feature => feature,
					:description => 'Team member should be able to insert new feature')

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

MeetingType.create(:name => 'Sprint Retrospective',
                    :description => 'Retrospective')

MeetingType.create(:name => 'Sprint Planning',
                    :description => 'Planning')

task = Task.create(:description => 'Create scaffolding for feature',
                   :project => project,
                   :feature => feature,
                   :sprint => sprint,
                   :task_status => task_status)
                   
User.create(:login => 'admin',
			:email => 'admin@example.com',
			:password_salt => '0-eVRdMdVnIb358gcyL3',
			:single_access_token => 'byw3v4tgeBZ5BqNSLmWY',
			:perishable_token => 'byw3v4tgeBZ5BqNSLmWY',
			:crypted_password => 'b9941856357d7040f3daa71bda942a3eccb44c5373c84f21d420a749bc2d25414440c81178f93afc9d223767f8fc3c24cc6dd740db9965caeb8fccdc1922f790',
			:persistence_token => 'c7eb1851954f54a476cab522ece7b04087aefe7ca778fa1cd2f42fa57bbc60ec5bced0a4635cb61a43c5ceb165449801f0b919555dbe773a56983829d3ff1fca'
			)
			                   
#TODO: Meeting and event