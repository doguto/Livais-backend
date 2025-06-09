class CreateNotices < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:notices)
      create_table :notices do |t|
        t.references :user, null: false, foreign_key: true
        t.string :notifiable_type, null: false
        t.bigint :notifiable_id, null: false

        t.timestamps
      end
    end
  end
end
