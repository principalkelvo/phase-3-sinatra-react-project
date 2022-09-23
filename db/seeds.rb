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

# t.string :comment
#       t.boolean :like
#       t.integer :view

5.times do
    Author.create(name: Faker::Name.unique.name)
end
# Seed your database here
Author.all.each do |author|
    category = Category.create(name: Faker::Book.genre )
    user=User.create(name: Faker::Name.unique.name)

    blog = Blog.create(title: Faker::Lorem.sentence, category_id: category.id ,content: Faker::Lorem.paragraphs(number: rand(5..18)).join("\n"), photographer: Faker::Name.unique.name, image: Faker::LoremFlickr.image, caption: Faker::Lorem.sentence, tag: Faker::Hobby.activity,language: "english",author_id: author.id, user_id: user.id)

    # create between 1 and 5 comments for each blog
    rand(1..5).times do
        random_user = User.order('RANDOM()').first
        Comment.create(comment: Faker::Lorem.sentence, like: false, view: 1, user_id: random_user.id, blog_id: blog.id)
    end

end

puts "✅ Done seeding!"
