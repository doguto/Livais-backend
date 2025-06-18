class CreateQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :quotes do |t|
      t.references :quoted_post, null: false, foreign_key: { to_table: :posts }, type: :bigint
      t.references :quoting_post, null: false, foreign_key: { to_table: :posts }, type: :bigint
      t.timestamps
    end
  end
end
