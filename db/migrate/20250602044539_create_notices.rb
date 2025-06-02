class CreateNotices < ActiveRecord::Migration[8.0]
  def change
    create_table :notices do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :notifiable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
