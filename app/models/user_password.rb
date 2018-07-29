class UserPassword < ApplicationRecord
  enum status: %i[dead live]
  enum source: %i[kitsu aozora]

  validates :user_id, presence: true
  validates :password, presence: true

  def password
    pass = super
    BCrypt::Password.new(pass) if pass
  end

  def password=(value)
    super(BCrypt::Password.create(value)) if value
  end
end
