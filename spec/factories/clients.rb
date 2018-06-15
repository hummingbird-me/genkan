FactoryBot.define do
  factory :client do
    redirect_uri 'http://localhost/'
    name { Faker::App.name }
    owner_id 'test'
  end
end
