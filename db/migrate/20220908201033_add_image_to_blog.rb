class AddImageToBlog < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :image, :string
  end
end
