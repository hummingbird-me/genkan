class Token < ApplicationRecord
  belongs_to :grant, required: true

  validates :grant, presence: true
  validates :expires_at, presence: true
end
