ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webrat'

class ActiveSupport::TestCase
  fixtures :all
end

module ActionController
  class IntegrationTest
    include Webrat::Methods
    include Webrat::Matchers

    setup do
      visit login_url
      assert_contain 'Login'
      fill_in 'Username', :with => 'admin'
      fill_in 'Password', :with => 'admin'
      click_button 'Login'
    end
  end
end

ActionDispatch::Integration::Session::DEFAULT_HOST = 'localhost:3000'

Webrat.configure do |config|
  config.mode = :rack
end