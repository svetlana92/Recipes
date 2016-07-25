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

puts 'Seed Category'
5.times do
  Category.create! name: Faker::Hipster.word
end

category_ids = Category.all.ids
10.times do
  Category.create! name: Faker::Hipster.word,
                   parent_id: category_ids.sample
end

category_ids = Category.all.ids
30.times do
  Category.create! name: Faker::Hipster.word,
                   parent_id: category_ids.sample
end

puts 'Seed Recipe'
category_ids = Category.all.ids
100.times do
  Recipe.create! name: Faker::Commerce.product_name,
                 description: Faker::Lorem.paragraphs(3, true).join("\r\n"),
                 image: File.new("#{Rails.root}/public/images/pizza.jpg"),
                 user: User.all.sample,
                 category_ids: category_ids.sample(Faker::Number.between(1, 4))
end
