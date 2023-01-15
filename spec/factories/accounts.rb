FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  trait :invalid do
    email { nil }
  end

  trait :verified do
    status { 'verified' }
  end
end