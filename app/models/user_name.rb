# frozen_string_literal: true

class UserName < ApplicationRecord
  enum status: { dead: 0, live: 1 }
  enum kind: { email: 0, username: 1 }

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :kind, presence: true

  has_many :passwords, class_name: 'UserPassword', foreign_key: 'user_id', primary_key: 'user_id'
end
