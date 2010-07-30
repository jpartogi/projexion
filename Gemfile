# Edit this Gemfile to bundle your application's dependencies.
# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified

source 'http://gemcutter.org'

## Bundle edge rails:
#gem "rails", "3.0.0.beta"
gem "rails", :git => 'git://github.com/rails/rails.git' # Rails 3.0.0.beta3

# Database drivers
gem "mysql"

# For security
#gem "authlogic", :git => 'git://github.com/scrum8/authlogic.git'
#gem "authlogic", :git => 'git://github.com/binarylogic/authlogic.git'
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'
#gem "declarative_authorization", :git => 'git://github.com/stffn/declarative_authorization.git'
gem "cancan", :git => 'git://github.com/ryanb/cancan.git'

#gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git'
gem 'will_paginate','3.0.pre'

# For cron jobs
# TODO: Activate whenever scheduler
#gem "whenever", "0.4.1", :git => "git://github.com/javan/whenever.git"

# If you are running passenger in production, make sure to remark the lines below.
# To run unicorn in production:
# $ bundle exec vendor/bin/unicorn -E production
# gem 'unicorn'

# To run thin in production:
# $ bundle exec vendor/bin/thin start
# gem 'thin'

# For testing
group :test do
  gem "webrat", "0.7.2.pre", :git => 'git://github.com/scrum8/webrat.git'
  gem "shoulda", :git => 'git://github.com/thoughtbot/shoulda.git', :require => nil
  gem "factory_girl", :git => 'git://github.com/thoughtbot/factory_girl.git', :require => nil
  gem "cucumber"
  gem "sqlite3-ruby"
  gem "rack-test"
end
