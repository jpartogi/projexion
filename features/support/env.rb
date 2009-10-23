# cucumber-0.1.11
# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
#Cucumber::Rails.use_transactional_fixtures

require 'webrat'
#require 'webrat/core'

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
#require 'cucumber/rails/rspec'
#require 'webrat/rspec-rails'

Webrat.configure do |config|
  config.mode = :rails
end
