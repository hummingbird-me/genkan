class PasswordChecker
  def initialize(name)
    @name = name
  end

  def validate_password!(password)
    return true if password_valid?(password)
    raise OAuth2Error::InvalidPassword
  end

  def password_valid?(password)
    passwords.any? { |p| p.password == password }
  end

  private

  def username
    UserName.live.find_by!(name: @name)
  rescue ActiveRecord::RecordNotFound
    raise OAuth2Error::UserNotFound, name
  end

  def passwords
    username.passwords.live
  end
end
