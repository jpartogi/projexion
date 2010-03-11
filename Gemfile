# Edit this Gemfile to bundle your application's dependencies.
# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified

source 'http://gemcutter.org'
source "http://gems.github.com"

## Bundle edge rails:
gem "rails", "3.0.0.beta"

# Database drivers
gem "mysql"

# For security
gem "authlogic", :git => 'git://github.com/binarylogic/authlogic.git'

#gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git'
gem 'will_paginate','3.0.pre'

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