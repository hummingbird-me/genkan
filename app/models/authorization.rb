# frozen_string_literal: true

# Represents a requested authorization of a client on behalf of a resource owner, given a list of
# scopes.
class Authorization
  # @return [String] the user ID this authorization would apply to
  attr_reader :user_id
  # @return [Client] the Client application which is requesting this authorization
  attr_reader :client

  # @param client [Client] the client application which is requesting authorization
  # @param user_id [String] the user ID this authorization would apply to
  # @param scopes [Array<String>] the list of scopes the client is requesting authorization of
  def initialize(client, user_id, scopes)
    @client = client
    @user_id = user_id
    @scopes = scopes
  end

  # @return [Grant] the existing grant, or (if there is no existing one) a new one
  def grant
    @grant ||= Grant.acceptable.where(user_id: user_id, client: client)
                    .first_or_initialize(expires_at: 6.months.from_now)
  end

  # @return [Array<String>] the list of new scopes to authorize for
  def scopes
    @scopes - existing_scopes
  end

  # @return [Boolean] whether there are new scopes which need explicit authorization from the user
  def new_scopes?
    scopes.present?
  end

  # @return [Array<String>] a list of scopes which have already been granted to this client by the
  #                         user
  def existing_scopes
    grant&.scopes || []
  end

  # @return [Boolean] whether this client is authorized to request the scopes it's requesting
  def valid_scopes?
    client.scopes_allowed?(@scopes)
  end

  # Approve this authorization request, updating the Grant scopes
  def approve
    grant.scopes += scopes
    grant.save!
  end
end
