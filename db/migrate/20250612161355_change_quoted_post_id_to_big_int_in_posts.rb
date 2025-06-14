class ChangeQuotedPostIdToBigIntInPosts < ActiveRecord::Migration[8.0]
  def change
    change_column :posts, :quoted_post_id, :bigint
  end
end
