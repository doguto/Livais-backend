class AddQuotePostToPosts < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :quoted_post, null: true, foreign_key: { to_table: :posts }
    add_column :posts, :quotes_count, :integer, default: 0, null: false
  end
end
