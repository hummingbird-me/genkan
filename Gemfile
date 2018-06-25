source 'https://rubygems.org'
ruby '2.4.1'

# Web
gem 'puma'
gem 'rails', '~> 5.2.0'

# Databases
gem 'connection_pool'
gem 'pg'
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'redis-rails'

# Database Extensions
gem 'flag_shih_tzu' # Bitfields

# Response Generation
gem 'graphql'
gem 'slim-rails'

# Assets
gem 'webpacker'

# Security
gem 'bcrypt'
gem 'jwt'

# Miscellanea
gem 'lograge'
gem 'sentry-raven'

# Optimizations
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
  gem 'simplecov-lcov'

  # Test our OAuth2 implementation against an actual client
  gem 'oauth2'
end

group :production, :staging do
  gem 'librato-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
