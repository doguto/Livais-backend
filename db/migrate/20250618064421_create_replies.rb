class CreateReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :replies do |t|
      t.references :parent_post, null: false, foreign_key: { to_table: :posts }, type: :bigint
      t.references :child_post, null: false, foreign_key: { to_table: :posts }, type: :bigint
      t.timestamps
    end
  end
end
