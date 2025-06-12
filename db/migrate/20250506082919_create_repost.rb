class CreateRepost < ActiveRecord::Migration[8.0]
  def change
    create_table :reposts do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end

    add_index :reposts, [:user_id, :post_id], unique: true
  end
end
