# Edit this Gemfile to bundle your application's dependencies.
# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified

source 'http://gemcutter.org'

gem "rake"
## Bundle edge rails:
gem "rails", "3.0.0.beta"
#gem "rails", :git => 'git://github.com/rails/rails.git'

# Database drivers
gem "mysql"

# For security
#gem "authlogic", :git => 'git://github.com/scrum8/authlogic.git'
gem "authlogic", :git => 'git://github.com/binarylogic/authlogic.git'
#gem "declarative_authorization", :git => 'git://github.com/stffn/declarative_authorization.git'
gem "cancan", :git => 'git://github.com/ryanb/cancan.git'

#gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git'
gem 'will_paginate','3.0.pre'

# For cron jobs
# TODO: Activate whenever scheduler
#gem "whenever", "0.4.1", :git => "git://github.com/javan/whenever.git"

# For testing
group :test do
  gem "webrat", "0.7.1.pre", :git => 'git://github.com/brynary/webrat.git'
  gem "shoulda", :git => 'git://github.com/thoughtbot/shoulda.git', :require => nil
  gem "factory_girl", :git => 'git://github.com/thoughtbot/factory_girl.git', :require => nil
  gem "cucumber"
  gem "sqlite3-ruby"
  gem "rack-test"
end