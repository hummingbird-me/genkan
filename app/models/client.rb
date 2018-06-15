class Client < ApplicationRecord
  PUBLIC_SCOPES = %w[profile.read openid].freeze

  include FlagShihTzu
  has_flags column: 'permissions', 1 => :children

  validates :key, presence: true
  validates :secret, presence: true
  validates :name, presence: true
  validates :owner_id, presence: true

  before_validation :generate_key, on: :create
  before_validation :generate_secret, on: :create

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

  private

  def generate_key
    self.key ||= SecureRandom.base58(20)
  end

  def generate_secret
    self.secret ||= SecureRandom.base58(120)
  end
end
