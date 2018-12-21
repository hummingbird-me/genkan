FactoryBot.define do
  factory :grant do
    client
    user_id { 'test' }
    expires_at { 1.month.from_now }
    scopes { [] }
  end
end
