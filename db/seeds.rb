puts "🌱 Seeding spices..."
# blogs = ["Croissant", "Rhubarb Pie", "Black and White Cookie", "Scone", "Banana Bread"]

# t.string :category
# t.string :title
# t.string :content
# t.string :photographer
# t.string :caption
# t.string :tag
# t.string :language
# t.string :image
# t.integer :author_id
# t.integer :user_id
Author.create(name: Faker::Name.unique.name)
Author.create(name: Faker::Name.unique.name)
Author.create(name: Faker::Name.unique.name)
Author.create(name: Faker::Name.unique.name)
# Seed your database here
Author.all.each do |author|
    3.times do 
    Blog.create(title: Faker::Lorem.sentence, category: Faker::Book.genre ,content: Faker::Lorem.paragraphs(number: rand(5..18)).join("\n"), photographer: Faker::Name.unique.name, image: Faker::LoremFlickr.image, caption: Faker::Lorem.sentence, tag: Faker::Hobby.activity,language: "english",author_id: author.id, user_id: author.id)
    end
end

puts "✅ Done seeding!"
