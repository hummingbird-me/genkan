class Client < ApplicationRecord
  PUBLIC_SCOPES = %w[profile.read openid].freeze

  include FlagShihTzu
  has_flags column: 'permissions', 1 => :children

  # Securely validate the passed-in secret is the one in the database
  #
  # @param secret [String] the secret to test against
  # @return [Boolean] whether the secret is correct
  def valid_secret?(secret)
    ActiveSupport::SecurityUtils.secure_compare(self.secret, secret)
  end

  # @return [Array<String>] the scopes which this client has access to
  def permitted_scopes
    scopes = PUBLIC_SCOPES.dup
    scopes << '_children' if children?
    scopes
  end
end
