source 'http://rubygems.org'

gem 'rails', '3.2.3'

gem 'mysql2'
gem "thin"

gem 'json'

gem "haml", "~> 3.1.4"
gem "kaminari", "~> 0.13.0"
gem "devise", "~> 1.5.2"
gem 'bitmask_attributes'
gem 'simple_form'
gem "meta-tags", :require => 'meta_tags'
gem "has_scope", "~> 0.5.1"
gem "bootstrap-sass"
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :git => 'git://github.com/anjlab/bootstrap-rails.git'
gem "bootstrap-datepicker-rails"
gem "cancan", "1.6.7"
gem "squeel"

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
  gem "therubyracer", "~> 0.9.8" #ExecJS runtime
end

group :production do
  # gem "passenger", "~> 3.0.9"
  gem "exception_notification", "~> 2.5.2"
  gem "unicorn", "~> 4.2.1"
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec-rails',        '~> 2.11.0'
  gem 'factory_girl_rails', '~> 3.5.0'
  gem 'guard-rspec'
  gem "pry-rails"
end

group :development do
  gem 'capistrano', :require => false
  gem 'capistrano-recipes', :require => false
  gem 'capistrano_colors', :require => false
  gem 'rvm-capistrano', :require => false
  gem 'rails_best_practices'
end

group :test do
  gem 'spork',              '>= 0.9.0.rc9'
  gem 'guard-spork'
  gem 'guard-bundler',      '~> 0.1.3'
  gem "capybara",           "~> 1.1.1"
  gem "database_cleaner"
  gem "shoulda"
  gem "ffaker", "~> 1.15.0"
  gem "launchy"
  gem "vcr"
  gem "fakeweb"

  gem 'rb-fsevent', '>= 0.4.3', :require => false
  gem 'growl',      '~> 1.0.3', :require => false
  gem 'rb-inotify', '>= 0.8.6', :require => false
  gem 'libnotify',  '~> 0.5.7', :require => false
end
