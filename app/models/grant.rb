# frozen_string_literal: true

# A Grant represents the period in which a client can log a user back in with an immediate redirect,
# not requiring explicit user interaction.  As such, a Grant only applies to clients using the
# Implicit Grant or Authorization Code Grant.
#
# The Grant is limited to a set of scopes, and if you request more scopes in a reauthorization
# request, the flow will still require user interaction.
#
# Grants will only be issued if a client has been configured with an HTTPS Redirect URI, otherwise
# it creates a significant security hole for any client using a non-confidential setup.
class Grant < ApplicationRecord
  include WithExpiration
  include WithRevocation

  scope :acceptable, -> { where.not('expires_at < ? AND revoked_at < ?', Time.now, Time.now) }

  belongs_to :client, required: true

  validates :client, presence: true
  validates :user_id, presence: true
end
