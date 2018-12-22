# frozen_string_literal: true

# Manages records which are revocable with the `revoked_at` column.
module WithRevocation
  extend ActiveSupport::Concern

  included do
    scope :revoked, -> { where.not('revoked_at < ?', Time.now) }
  end

  # Revoke this
  #
  # @return [void]
  def revoke!
    update(revoked_at: Time.now) unless revoked?
  end

  # @return [Boolean] whether this has been revoked
  def revoked?
    revoked_at&.past?
  end
end
