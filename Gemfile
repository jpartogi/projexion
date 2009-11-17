# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified
clear_sources

gem "rails", "3.0.pre", :git => "git://github.com/rails/rails.git", :path => "railties"

source "http://gemcutter.org"
#source "http://gems.github.com"

gem "webrat"
gem "shoulda"
gem "sqlite3-ruby"
gem "rack-test"
gem "cucumber"

gem "rack", "1.0.1", :git => "git://github.com/rails/rack.git"

gem "rack-mount", "0.0.1", :git => "git://github.com/rails/rack-mount.git"
gem "arel", "0.2.pre", :git => "git://github.com/rails/arel.git", :path => "arel"