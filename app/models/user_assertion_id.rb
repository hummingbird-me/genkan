class UserAssertionID < ApplicationRecord
  enum source: %i[facebook twitter ao_facebook]

  validates :user_id, presence: true
  validates :assertion, presence: true, uniqueness: { scope: :source }
  validates :source, presence: true
end
