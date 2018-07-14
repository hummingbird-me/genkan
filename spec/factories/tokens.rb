FactoryBot.define do
  factory :token do
    grant
    expires_at { 1.month.from_now }
    scopes []
  end
end
