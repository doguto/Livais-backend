class ChangeColumnTypes < ActiveRecord::Migration[8.0]
  def change
    change_column :ai_users, :user_id, :bigint, null: false
    change_column :ai_users, :ai_model_id, :bigint, null: false
    change_column :likes, :user_id, :bigint
    change_column :likes, :post_id, :bigint
    change_column :reposts, :user_id, :bigint, null: false
    change_column :reposts, :post_id, :bigint, null: false
    change_column :notices, :user_id, :bigint, null: false
    change_column :notices, :notifiable_id, :bigint, null: false
    change_column :posts, :user_id, :bigint
    change_column :posts, :reply_to_id, :bigint
    change_column :follows, :follower_id, :bigint
    change_column :follows, :followed_id, :bigint
    change_column :profiles, :user_id, :bigint, null: false
  end
end
