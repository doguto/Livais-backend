class RenameAndChangeTypeUserIdToUserInAiUsers < ActiveRecord::Migration[8.0]
  def up
    remove_column :ai_users, :user_id
    add_reference :ai_users, :user, foreign_key: true
  end
end
