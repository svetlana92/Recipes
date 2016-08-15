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
               password: 'password',
               created_at: Faker::Date.between(20.days.ago, Date.today)
end

User.create! name: 'Svetlana',
             email: 'svetlana@gmail.com',
             age: 24,
             password: 'password'

puts 'Seed Category'
5.times do
  Category.create! name: Faker::Hipster.word,
                   created_at: Faker::Date.between(20.days.ago, Date.today)
end

category_ids = Category.all.ids
10.times do
  Category.create! name: Faker::Hipster.word,
                   parent_id: category_ids.sample,
                   created_at: Faker::Date.between(20.days.ago, Date.today)
end

category_ids = Category.all.ids
30.times do
  Category.create! name: Faker::Hipster.word,
                   parent_id: category_ids.sample,
                   created_at: Faker::Date.between(20.days.ago, Date.today)
end

puts 'Seed Measures'
measure_names = %w(ml liter gram kg tbsp tsp cup item)
Measure.create!(measure_names.map{ |measure_name| { name: measure_name } })



puts 'Seed Recipe'
category_ids = Category.all.ids
100.times do
  user = User.all.sample
  Recipe.create!({
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs(3, true).join("\r\n").truncate(500, separator: '.'),
    image: File.new("#{Rails.root}/public/images/pizza.jpg"),
    user: user,
    category_ids: category_ids.sample(Faker::Number.between(1, 3)),
    created_at: Faker::Date.between(user.created_at, Date.today),
    ingredients_attributes: 3.times.map do
      {
        name: Faker::Beer.name,
        quantity: Faker::Number.between(1, 50),
        measure: Measure.all.sample
      }
    end
  })
end

puts 'Seed Comments'
Recipe.all.each do |recipe|
  rand(5..20).times do
    recipe.comments.create! user: User.all.sample,
                            comment: Faker::Lorem.sentences(rand(1..5)).join("\s"),
                            created_at: Faker::Date.between(recipe.created_at, Date.today)

  end
end
