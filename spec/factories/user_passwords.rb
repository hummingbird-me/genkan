# frozen_string_literal: true

FactoryBot.define do
  factory :user_password do
    user_id { rand(1..10_000) }
    password { Faker::Internet.password }
  end
end
