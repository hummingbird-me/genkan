# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Web
gem 'puma'
gem 'rails', '~> 6.1.3'

# Databases
gem 'connection_pool'
gem 'pg'
gem 'redis'

# Database Extensions
gem 'flag_shih_tzu' # Bitfields

# Response Generation
gem 'addressable'
gem 'graphql'
gem 'slim-rails'

# Assets
gem 'sass-rails'

# Security
gem 'bcrypt'
gem 'json-jwt'
gem 'jwt'

# Miscellanea
gem 'lograge'
gem 'sentry-rails'
gem 'sentry-ruby'

# Optimizations
gem 'bootsnap', require: false
gem 'fast_blank'
gem 'hiredis'
gem 'oj'
gem 'oj_mimic_json'

group :development do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'graphiql-rails'

  # Console Improvements
  gem 'spring'
  gem 'spring-watcher-listen'

  # Guard notices filesystem changes and ~~does things~~
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'listen'
end

group :test do
  # RSpec
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webmock'

  # Coverage Reporting
  gem 'simplecov'

  # Test our OAuth2 implementation end-to-end in an actual client
  gem 'capybara'
  gem 'oauth2'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
