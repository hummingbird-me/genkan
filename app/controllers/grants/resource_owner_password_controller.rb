module Grants
  class ResourceOwnerPasswordController < ApplicationController
    ACCESS_TOKEN_LIFETIME = 1.month

    include ClientParameter
    include ScopeParameter

    def grant
      validate_password!

      render json: {
        access_token: access_token.to_jwt,
        token_type: 'bearer'
      }
    end

    rescue_from OAuth2Error do |exception|
      render json: exception, status: 400
    end

    private

    def validate_password!
      PasswordChecker.new(user_id).validate_password!(params[:password])
    end

    def user_id
      raise OAuth2Error::UserNotFound unless params[:username]

      UserFinder.new(params[:username]).user_id!
    end

    def access_token
      @access_token ||= Token.create!(
        user_id: user_id,
        client: client,
        scopes: scopes,
        expires_in: ACCESS_TOKEN_LIFETIME
      )
    end
  end
end
