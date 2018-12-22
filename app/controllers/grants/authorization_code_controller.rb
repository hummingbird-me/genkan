# frozen_string_literal: true

module Grants
  # Handles the Authorization Code Flow (also known as the "three-legged" flow)
  class AuthorizationCodeController < ApplicationController
    include Framebuster
    include CookieAuthentication
    include ClientParameter
    include ScopeParameter
    include OAuth2FatalErrorHandling
    include OAuth2ErrorHandling
    include OAuth2Redirect

    helper AuthorizePathHelpers

    def ask
      @authorization = Authorization.new(client, user_id, scopes)
      render
    end

    def grant
      @authorization = Authorization.new(client, user_id, scopes)
      @authorization.approve

      redirect_with code: Token.create!(
        client: client,
        user_id: user_id,
        scopes: scopes,
        expires_at: 6.months.from_now
      ).to_jwt
    end

    def reject
      raise OAuth2Error::AccessDenied
    end
  end
end
