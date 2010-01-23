# Edit this Gemfile to bundle your application's dependencies.
# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified

clear_sources

source "http://gemcutter.org"
#source "http://gems.github.com"

## Bundle edge rails:
gem "rails", "3.0.pre", :git => "git://github.com/rails/rails.git"
#gem "rails", "3.0.pre"

## Bundle the gems you use:
# gem "bj"
# gem "hpricot", "0.6"
# gem "sqlite3-ruby", :require_as => "sqlite3"
# gem "aws-s3", :require_as => "aws/s3"

## Bundle gems used only in certain environments:
# gem "rspec", :only => :test
# only :test do
#   gem "webrat"
# end 

# For testing
only :test do
  gem "webrat", :only => :test
  gem "shoulda", :only => :test
  gem "cucumber"
end

# Database drivers
gem "mysql"
gem "sqlite3-ruby", :only => :test


gem "rack-test"
gem "rack", "1.1.0", :git => "git://github.com/rails/rack.git"
gem "arel", "0.2.pre", :git => "git://github.com/rails/arel.git", :path => "arel"

# For security
gem "authlogic", :git => 'git://github.com/binarylogic/authlogic.git'

# For cron jobs
gem "whenever", "0.4.1", :git => "git://github.com/javan/whenever.git"