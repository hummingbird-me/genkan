# Represents a grant of permissions to a client for a given user and set of scopes. The grant can be
# manually revoked and has an expiration date.  When the grant is no longer valid, neither are the
# tokens granted under it.
class Grant < ApplicationRecord
  scope :revoked, -> { where('revoked_at < ?', Time.now) }
  scope :expired, -> { where('expires_at < ?', Time.now) }
  scope :valid, -> { where.not('expires_at < ? AND revoked_at < ?', Time.now, Time.now) }

  belongs_to :client, required: true
  has_many :tokens, dependent: :destroy

  validates :client, presence: true
  validates :user_id, presence: true
  validates :expires_at, presence: true

  # @return [Boolean] whether this grant has expired yet
  def expired?
    expires_at&.past?
  end

  # @return [Boolean] whether this grant has been revoked
  def revoked?
    revoked_at&.past?
  end

  # Revoke this grant immediately.  All Tokens issued under this grant are also revoked.
  # @return [void]
  def revoke!
    return if revoked?
    update(revoked_at: Time.now)
    tokens.update_all(revoked_at: Time.now, updated_at: Time.now)
  end
end
