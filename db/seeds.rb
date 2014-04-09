# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Create 5 users with their own posts
5.times do
  password = Faker::Lorem.characters(10)
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password)
  user.skip_confirmation!
  user.save

  # Note: by calling `User.new` instead of `create`,
  # we create an instance of a user which isn't saved to the database.
  # The `skip_confirmation!` method sets the confirmation date
  # to avoid sending an email. The `save` method updates the database.

  5.times do
    post = Post.create(
      user: user,
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph)
    # set the created_at to a time within the past year
    post.update_attribute(:created_at, Time.now - rand(600..31536000))
  end
end

# 24.times do
#   p = Post.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
#   3.times do
#     p.comments.create(body: Faker::Lorem.paragraph)
#   end
# end



user = User.first
user.skip_reconfirmation!
user.update_attributes(email: 'davegreg@radicalskeptic.net', password: 'victor123', password_confirmation: 'victor123')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

