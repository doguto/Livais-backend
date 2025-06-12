class CreateAiUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_users do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
