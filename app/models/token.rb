class Token < ApplicationRecord
  belongs_to :grant, required: true

  validates :grant, presence: true
  validates :expires_at, presence: true

  def expires_in
    expires_at - Time.now
  end

  # @return [Boolean] whether this grant has expired yet
  def expired?
    expires_at&.past?
  end

  def revoked?
    revoked_at&.past? || grant.revoked?
  end

  def acceptable?
    !(expired? || revoked?)
  end

  def to_jwt
    TokenParser.dump(
      jti: id,
      scopes: scopes,
      sub: grant.user_id,
      iat: created_at.to_i,
      exp: expires_at.to_i
    )
  end
end
