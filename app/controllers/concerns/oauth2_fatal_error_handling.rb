# frozen_string_literal: true

module OAuth2FatalErrorHandling
  extend ActiveSupport::Concern

  def render_oauth2_fatal_error(exception)
    @error = exception
    render 'grants/error'
  end

  included do
    rescue_from OAuth2Error::FatalError, with: :render_oauth2_fatal_error
  end
end
