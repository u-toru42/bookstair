FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Name.name }
  end
end