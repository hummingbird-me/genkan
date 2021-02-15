# frozen_string_literal: true

module OAuth2ErrorHandling
  extend ActiveSupport::Concern

  def redirect_from_oauth2_error(exception)
    redirect_with(exception.as_json)
  end

  included do
    rescue_from OAuth2Error, with: :redirect_from_oauth2_error
  end
end
