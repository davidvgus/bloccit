
require 'faker'

FactoryGirl.define do
  factory :comment do
    post
    user
    body { Faker::Lorem.paragraph }
  end
end
