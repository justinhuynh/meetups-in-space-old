# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
require 'faker'

100.times do
  meetup_attributes = {
    name: "#{Faker::Hacker.ingverb} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
    location: "#{Faker::Address.street_address}, #{Faker::Address.city} #{Faker::Address.state_abbr}",
    description: "#{Faker::Hacker.say_something_smart}"
  }
  Meetup.create(meetup_attributes)
end

100.times do
  user_attributes = {
    provider: "#{Faker::App.name}",
    uid: "#{Faker::Internet.password}",
    username: "#{Faker::Internet.user_name}",
    email: "#{Faker::Internet.email}",
    avatar_url: "#{Faker::Avatar.image}"
  }
  User.create(user_attributes)
end

User.all.each do |user|
  10.times do
    meetup = Meetup.find(rand(Meetup.count-1)+1)
    unless user.meetups.include?(meetup)
      user.meetups << meetup
    end
  end
end
