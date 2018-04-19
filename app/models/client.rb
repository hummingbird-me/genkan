class Client < ApplicationRecord
  # Securely validate the passed-in secret is the one in the database
  #
  # @param secret [String] the secret to test against
  # @return [Boolean] whether the secret is correct
  def valid_secret?(secret)
    ActiveSupport::SecurityUtils.secure_compare(self.secret, secret)
  end
end
