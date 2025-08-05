class AddIndexToUsersProviderAndUid < ActiveRecord::Migration[8.0]
  def change
    add_index :users, [:uid, :provider], unique: true
  end
end
