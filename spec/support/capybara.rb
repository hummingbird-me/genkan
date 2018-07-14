require 'capybara/rails'
require 'capybara/rspec'

Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :selenium_chrome_headless

module CapybaraHelpers
  def capybara_host
    server = Capybara.current_session.server
    "#{server.host}:#{server.port}"
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers, type: :feature
end
