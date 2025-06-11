class AddReplyToIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :reply_to_id, :bigint
    add_index :posts, :reply_to_id
    add_foreign_key :posts, :posts, column: :reply_to_id
  end
end
