class UpdatePosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :content, :text
    remove_column :posts, :user_id, :integer
    change_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :content, limit: 280
      t.string :status, default:"published"
    end
  end
end
