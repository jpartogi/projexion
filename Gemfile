# Edit this Gemfile to bundle your application's dependencies.
# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified

source 'http://gemcutter.org'

## Bundle edge rails:
gem "rails", "3.0.5"
#gem "rails", :git => 'git://github.com/rails/rails.git' # Rails 3.0.0.beta3

# Database drivers
gem 'bson_ext'
gem 'mongoid', "2.0.0.rc.7"

# For security
gem 'devise', '1.2.rc'
gem "cancan"

#gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git'
gem 'will_paginate','3.0.pre2'

# For cron jobs
# TODO: Activate whenever scheduler
#gem "whenever", "0.4.1", :git => "git://github.com/javan/whenever.git"

# If you are running passenger in production, make sure to remark the lines below.
# To run unicorn in production:
# $ bundle exec unicorn -E production --port 6000 --daemonize
gem 'unicorn'

# To run thin in production:
# $ bundle exec vendor/bin/thin start
# gem 'thin'

# For testing
group :test do
  gem "webrat", "0.7.3"
  gem "shoulda"
  gem "factory_girl"
  gem "cucumber"
  gem "rack-test"
end

group :test, :development do
  gem "rack-test"
  gem "rspec-rails", ">= 2.5.0"
end
