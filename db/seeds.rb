Faker::Config.locale = :ja

15.times do |n|
  name = Faker::Book.title
  content = Faker::Color.name
  end_date = Faker::Date.in_date_period(year: 2021, month: 2)
  Task.create!(name: name,
              content: content,
              end_date: end_date
  )
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
