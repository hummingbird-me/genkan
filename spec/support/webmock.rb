# frozen_string_literal: true

require 'webmock/rspec'

WebMock.disable_net_connect!(allow: [
  'robohash.org',
  'codeclimate.com',
  %r{pigment.github.io/fake-logos},
  'lorempixel.com',
  'localhost'
])

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    WebMock.disable!
  end
  config.after(:each, type: :feature) do
    WebMock.enable!
  end
end
