class UpdateUsersTable < ActiveRecord::Migration[8.0]
  def change
    change_table :users do |t|
      t.string :name
      t.string :email, null:false, index: {unique: true}
      t.string :password
    end
    remove_column :users, :updated_at, :datetime
  end
end
