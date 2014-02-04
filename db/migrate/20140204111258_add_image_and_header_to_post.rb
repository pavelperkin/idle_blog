class AddImageAndHeaderToPost < ActiveRecord::Migration
  def change
    add_column :posts, :image, :string
    add_column :posts, :header, :string
  end
end
