puts "🌱 Seeding spices..."
blogs = ["Croissant", "Rhubarb Pie", "Black and White Cookie", "Scone", "Banana Bread"]

# t.string :category
# t.string :title
# t.string :content
# t.string :photographer
# t.string :caption
# t.string :tag
# t.string :language
# t.integer :author_id
# t.integer :user_id
Author.create(name: "Northside")
Author.create(name: "Southside")
Author.create(name: "Eastside")
Author.create(name: "Westside")
# Seed your database here
Author.all.each do |author|
    3.times do 
    Blog.create(title: blogs.sample, category: blogs.sample,content: blogs.sample, photographer: blogs.sample, caption: blogs.sample, tag:blogs.sample,language: "english",author_id: author.id, user_id: author.id)
    end
end

puts "✅ Done seeding!"
