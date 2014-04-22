require 'faker'

FactoryGirl.define do
  sequence(:email) { |n| "#{Faker::Name.first_name}#{n}@#{Faker::Internet.domain_name}" }

  factory :user do
    name { Faker::Name.name }
    email
    password { Faker::Lorem.characters(10) }
    password_confirmation { |user| user.password }
    after(:build) { |user| user.skip_confirmation! }
  end
end
