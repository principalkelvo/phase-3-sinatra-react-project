class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.string :photographer
      t.string :caption
      t.string :tag
      t.string :language
      t.integer :author_id
      t.integer :user_id
      t.integer :category_id
    end
  end
end
