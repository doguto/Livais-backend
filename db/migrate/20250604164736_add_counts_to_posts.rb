class AddCountsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :likes_count, :integer, default: 0, null: false
    add_column :posts, :replies_count, :integer, default: 0, null: false
    add_column :posts, :reposts_count, :integer, default: 0, null: false
  end
end
