require 'faker'

FactoryGirl.define do
  sequence(:email) { |n| "#{Faker::Name.first_name}#{n}@#{Faker::Internet.domain_name}" }

  factory :comment do
    post
    user
    body { Faker::Lorem.paragraph }
  end

  factory :user do
    name { Faker::Name.name }
    email
    password { Faker::Lorem.characters(10) }
    password_confirmation { |user| user.password }
    after(:build) { |user| user.skip_confirmation! }
  end

  factory :post do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraph }
    user
    topic
  end

  factory :topic do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
