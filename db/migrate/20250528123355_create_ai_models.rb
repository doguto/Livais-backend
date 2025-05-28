class CreateAiModels < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_models do |t|
      t.string :model
      t.string :string

      t.timestamps
    end
  end
end
