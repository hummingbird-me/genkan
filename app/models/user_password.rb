# frozen_string_literal: true

class UserPassword < ApplicationRecord
  enum status: { dead: 0, live: 1 }
  enum source: { kitsu: 0, aozora: 1 }

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
