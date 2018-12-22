# frozen_string_literal: true

# Manages records which expire using the `expires_at` column.
module WithExpiration
  extend ActiveSupport::Concern

  included do
    scope :expired, -> { where.not('expires_at < ?', Time.now) }

    validates :expires_at, presence: true
  end

  # Set the expiration to occur by a duration
  #
  # @param duration [Integer] how far in the future to set the expiry
  # @return [void]
  def expires_in=(duration)
    self.expires_at = duration.from_now
  end

  # @return [Integer] the time remaining before this expires
  def expires_in
    Time.now - expires_at
  end

  # @return [Boolean] whether this has expired yet
  def expired?
    expires_at&.past?
  end
end
