FactoryBot.define do
  factory :user_name do
    user_id { rand(1..10_000) }
    name { Faker::Internet.email }
    kind :email
  end
end
