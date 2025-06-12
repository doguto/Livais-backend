class RemovePostIdFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :post_id, :integer
  end
end
