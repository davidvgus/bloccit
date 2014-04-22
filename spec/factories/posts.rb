
require 'faker'


FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraph }
    user
    topic
  end
end
