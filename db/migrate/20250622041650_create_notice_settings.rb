class CreateNoticeSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :notice_settings do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.boolean :like_enable, null: false, default: true
      t.boolean :repost_enable, null: false, default: true
      t.boolean :quote_enable, null: false, default: true
      t.boolean :reply_enable, null: false, default: true
      t.boolean :follow_enable, null: false, default: true
      t.timestamps
    end
  end
end
