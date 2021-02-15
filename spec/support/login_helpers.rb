# frozen_string_literal: true

module LoginHelpers
  extend ActiveSupport::Concern

  module Hook
    def token
      TokenVerifier.new(Thread.current[:token] || cookies[:token]).token
    end
  end

  # Set the token for this test
  #
  # @param token [String] the token to use
  # @return [void]
  def token=(token)
    Thread.current[:token] = token
  end

  # Login as a User
  #
  # @param user_id [String] the User ID to log in as
  # @return [void]
  def login_as(user_id)
    self.token = Token.create!(
      user_id: user_id,
      client: Client.first,
      expires_at: 5.months.from_now
    ).to_jwt
  end
end

CookieAuthentication.prepend(LoginHelpers::Hook)

RSpec.configure do |c|
  c.include LoginHelpers

  c.after(:example) do
    Thread.current[:token] = nil
  end
end
