FactoryBot.define do
  factory :token do
    grant
    user_id 'test'
    expires_at { 1.month.from_now }
    scopes []
  end
end
