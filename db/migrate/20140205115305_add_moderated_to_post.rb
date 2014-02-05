class AddModeratedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :moderated, :boolean, default: false
  end
end
