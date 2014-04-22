# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

topics = []
11.times do
  topics << FactoryGirl.create(:topic)
end

# Create 5 users with their own posts
5.times do
  user = FactoryGirl.build(:user)

  40.times do
    topic = topics.first
    post = FactoryGirl.build(:post, user: user, topic: topic)
    # set the created_at to a time within the past year
    post.update_attribute(:created_at, Time.now - rand(600..31536000))
    post.update_rank
    post.save!
    1.times do
      FactoryGirl.create(:comment, user: user, post: post)
    end

    topics.rotate!
  end
  user.save!
end

admin = User.new(name: 'Admin User',
                 email: 'admin@example.com',
                 password: ENV['USER1_PASSWORD'],
                 password_confirmation: ENV['USER1_PASSWORD'])
admin.skip_confirmation!
admin.save
admin.update_attribute(:role, 'admin')


#create a moderator
moderator = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
moderator.skip_confirmation!
moderator.save
moderator.update_attribute(:role, 'moderator')

# Create a member
member = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

