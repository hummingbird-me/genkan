# frozen_string_literal: true

# The UserFinder service looks up a user by a given login name.  Login names are the various keys
# which a user can use to log in.  When a user registers, the first login name they're assigned is
# their email address.  However, a user can have as many login names as is necessary for other
# services.
class UserFinder
  # @param name [String] the login name we want to look up
  def initialize(name)
    @name = name
  end

  # @return [String] the User ID if the login name is registered
  # @raise [OAuth2Error::UserNotFound] the login was not found in our records
  def user_id!
    user_id || (raise OAuth2Error::UserNotFound)
  end

  # @return [String, nil] the User ID if the login name is registered, otherwise nil
  def user_id
    UserName.live.find_by(name: @name)&.user_id
  end
end
