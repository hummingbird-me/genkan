source 'https://rubygems.org'
ruby '2.5.1'

# Web
gem 'puma'
gem 'rails', '~> 5.2.1'

# Databases
gem 'connection_pool'
gem 'pg'
gem 'redis'
gem 'redis-rails'

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
gem 'sentry-raven'

# Optimizations
gem 'bootsnap', require: false
gem 'fast_blank'
gem 'hiredis'
gem 'oj'
gem 'oj_mimic_json'

group :development do
  gem 'web-console'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'graphiql-rails'

  # Console Improvements
  gem 'pry-byebug'
  gem 'pry-rails'
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

group :production, :staging do
  gem 'librato-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
