# frozen_string_literal: true

class UserAssertionID < ApplicationRecord
  enum source: { facebook: 0, twitter: 1, ao_facebook: 2 }

  validates :user_id, presence: true
  validates :assertion, presence: true, uniqueness: { scope: :source }
  validates :source, presence: true
end
