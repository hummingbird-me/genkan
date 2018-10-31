class Token < ApplicationRecord
  include WithExpiration
  include WithRevocation

  belongs_to :client, required: true

  validates :client, presence: true
  validates :user_id, presence: true

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
