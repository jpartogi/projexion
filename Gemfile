# Edit this Gemfile to bundle your application's dependencies.
# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified

source 'http://gemcutter.org'
#source "http://gems.github.com"

# For webserver
# gem "rack", "1.1.0", :git => "git://github.com/rails/rack.git"

## Bundle edge rails:
gem "rails", "3.0.0.beta"
#gem "rails", "3.0.pre"

# Database drivers
gem "mysql"

# For security
gem "authlogic", :git => 'git://github.com/binarylogic/authlogic.git'

# For cron jobs
# gem "whenever", "0.4.1", :git => "git://github.com/javan/whenever.git"

# For testing
group :test do
  gem "webrat"
  gem "shoulda", :git => 'git://github.com/thoughtbot/shoulda.git', :require => nil
  gem "cucumber"
  gem "sqlite3-ruby"
  gem "rack-test"
end