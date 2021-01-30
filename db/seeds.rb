Faker::Config.locale = :ja
require 'securerandom'
# User.create!(name: "user_admin",
#             email: "user_admin@test.com",
#             password: "password",
#             admin: true
# )

10.times do |n|
  user_name = Faker::Games::Pokemon.name
  email = SecureRandom.hex(5)
  User.create!(name: user_name,
              email: "#{email}@test.com",
              password: "password",
              admin: false
  )
end

10.times do |n|
  name = Faker::Book.genre
  Label.create!(name: name)
end

10.times do |n|
  task_name = Faker::Book.title
  Task.create!(name: task_name,
              content: task_name,
              user: User.offset(rand(User.count)).first
  )
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
