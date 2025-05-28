class AddAiModelToAiUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :ai_users, :ai_model, null: false, foreign_key: true
  end
end
