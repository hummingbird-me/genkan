# frozen_string_literal: true

# Parses and verifies the list of scopes in a request's params[:scope] field
module ScopeParameter
  extend ActiveSupport::Concern

  # The list of valid scopes.
  # TODO: move this into a YML file to make customization easier
  VALID_SCOPES = %w[
    library.read
    library.write
    profile.read
    profile.write
    posts.write
    posts.read
    public
    _all
  ].freeze

  # @return [Array] the list of new scopes requested here
  # @raise [OAuth2Error::InvalidScope] the scopes requested were invalid
  def scopes
    @scopes ||= begin
      raise OAuth2Error::InvalidScope if requested_scopes.blank?
      raise OAuth2Error::InvalidScope, invalid_scopes if invalid_scopes.present?

      requested_scopes
    end
  end

  # Parses the list of scopes in the 'scopes' query parameter according to the RFC and returns it
  #
  # @return [Array<String>] the scopes requested by the client
  def requested_scopes
    @requested_scopes ||= params[:scope]&.split(' ')
  end

  # Finds any scopes which are being requested but do not exist.  These scopes are invalid.
  #
  # @return [Array<String>] the scopes which aren't valid
  def invalid_scopes
    @invalid_scopes ||= requested_scopes - VALID_SCOPES
  end
end
