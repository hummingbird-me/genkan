# frozen_string_literal: true

class UserName < ApplicationRecord
  enum status: %i[dead live]
  enum kind: %i[email username]

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :kind, presence: true

  has_many :passwords, class_name: 'UserPassword', foreign_key: 'user_id', primary_key: 'user_id'
end
