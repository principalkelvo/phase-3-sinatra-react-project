class AddTimestampToBlog < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :created_at, :timestamp
    add_column :blogs, :updated_at, :timestamp
    add_column :users, :created_at, :timestamp
    add_column :users, :updated_at, :timestamp
    add_column :authors, :created_at, :timestamp
    add_column :authors, :updated_at, :timestamp
  end
end
