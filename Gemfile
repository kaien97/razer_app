source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Run Scheduled scripts
gem 'whenever', require: false

# Charts
gem 'chart-js-rails'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem "aws-sdk-s3", require: false

# authentication
gem 'devise', '~> 4.7.1'

# integrations
gem 'oauth2', '~> 1.4.2'

# Bootstrap
gem 'bootstrap-sass', '~> 3.4.1'
gem 'jquery-rails', '~> 4.3.5'
gem 'jquery-ui-rails', '~> 6.0.1'

# Easy model search for ids
gem 'friendly_id', '~> 5.1.0'

# pagination
gem 'bootstrap-will_paginate', '~> 1.0.0'
gem 'will_paginate', '~> 3.1.8'

# For fun http requests
gem 'httparty', '~> 0.17.1'

# Token Based Authentication
gem 'jwt', '~> 2.2.1'
# JSON encryption
gem 'jwe', '~> 0.4.0'

# Passing data to javascript
gem 'gon', '~> 6.2.1'

# active model serializers
gem 'active_model_serializers', "~> 0.10.10"
# active storage validations
gem "active_storage_validations", "~> 0.6.1"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # For Windows
  gem 'wdm', '>= 0.1.0' if Gem.win_platform?
  # Environment
  gem 'dotenv-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'

end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
