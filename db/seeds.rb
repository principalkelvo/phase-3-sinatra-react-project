puts "🌱 Seeding spices..."
categories_names = ["News", "Sports","Business","Life","Travel","Entertainment","Tech"]

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

80.times do
    Author.create(name: Faker::Name.unique.name)
end
# Seed your database here
# create categories
categories_names.each do |category|
    category=Category.create(name: category)
#create users
user=User.create(name: Faker::Name.unique.name)

Author.all.each do |author|

    blog = Blog.create(title: Faker::Lorem.sentence, category_id: category.id ,content: Faker::Lorem.paragraphs(number: rand(5..18)).join("\n"), photographer: Faker::Name.unique.name, image: Faker::LoremFlickr.image, caption: Faker::Lorem.sentence, tag: Faker::Hobby.activity,language: "english",author_id: author.id, user_id: user.id)

    # create between 1 and 5 comments for each blog
    rand(1..5).times do
        random_user = User.order('RANDOM()').first
        Comment.create(comment: Faker::Lorem.sentence, like: false, view: 1, user_id: random_user.id, blog_id: blog.id)
    end

end
end

puts "✅ Done seeding!"
