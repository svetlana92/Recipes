# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Seed User'
20.times do
  User.create! name: Faker::Name.name,
               email: Faker::Internet.email,
               age: Faker::Number.between(10, 80),
               password: 'password'
end

User.create! name: 'Svetlana',
             email: 'svetlana@gmail.com',
             age: 24,
             password: 'password'

puts 'Seed Recipe'
100.times do
  Recipe.create! name: Faker::Commerce.product_name,
                 description: Faker::Lorem.paragraphs(3, true).join("\r\n"),
                 image: File.new("#{Rails.root}/public/images/pizza.jpg"),
                 user: User.all.sample
end
