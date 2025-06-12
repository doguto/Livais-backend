class RenameOldColumnNameToNewColumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :posts, :text, :content
  end
end
