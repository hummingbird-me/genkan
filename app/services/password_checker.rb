# The PasswordChecker class encapsulates the task of verifying an entered password against our
# stored passwords for a given User ID.  A single User can have multiple passwords, though most will
# only have one live one.  There are some exceptions, however: if the user merges their Aozora
# account we can have two passwords on record (their Kitsu and Aozora passwords)
class PasswordChecker
  # @param user_id [String] the ID of the User we wish to authenticate
  def initialize(user_id)
    @user_id = user_id
  end

  # Checks a password, raising an exception if it is not valid
  #
  # @param password [String] the password to check against our records
  # @return [Boolean] whether the password is valid for this user
  # @raise [OAuth2Error::InvalidPassword] the password is invalid
  def validate_password!(password)
    return true if password_valid?(password)

    raise OAuth2Error::InvalidPassword
  end

  # Checks a password, returning a boolean value of the validity
  #
  # @param password [String] the password to check against our records
  # @return [Boolean] whether the password is valid for this user
  def password_valid?(password)
    # This may look like a basic == check but the lefthand side is a BCrypt::Password
    passwords.any? { |p| p.password == password }
  end

  private

  def passwords
    UserPassword.live.where(user_id: @user_id)
  end
end
