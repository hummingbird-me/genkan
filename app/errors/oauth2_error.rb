# frozen_string_literal: true

class OAuth2Error < StandardError
  # Fatal Errors (no redirect)
  class FatalError < OAuth2Error; end

  class InvalidClient < FatalError; end

  class InvalidRedirect < FatalError; end

  # Less-fatal errors (redirect)
  class InvalidRequest < OAuth2Error; end

  class UnauthorizedClient < OAuth2Error; end

  class AccessDenied < OAuth2Error; end

  class UnsupportedResponseType < OAuth2Error; end

  class InvalidScope < OAuth2Error
    attr_reader :scopes

    def initialize(scopes = nil)
      @scopes = scopes
    end
  end

  class ServerError < OAuth2Error; end

  class TemporarilyUnavailable < OAuth2Error; end

  class InvalidGrant < OAuth2Error; end

  # Resource Owner Password Grant errors
  class UserNotFound < InvalidGrant
    def error_code
      'invalid_grant'
    end

    def i18n_scope
      'oauth2.errors.user_not_found'
    end
  end

  class InvalidPassword < InvalidGrant
    def error_code
      'invalid_grant'
    end

    def i18n_scope
      'oauth2.errors.invalid_password'
    end
  end

  def message
    I18n.t(:title, scope: i18n_scope)
  end

  def description
    I18n.t(:description, scope: i18n_scope)
  end

  def as_json(*opts)
    {
      error: error_code,
      error_description: description
    }.as_json(*opts)
  end

  private

  def error_code
    @error_code ||= self.class.name.demodulize.underscore
  end

  def i18n_scope
    "oauth2.errors.#{error_code}"
  end
end
