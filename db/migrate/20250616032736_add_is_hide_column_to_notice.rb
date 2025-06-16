class AddIsHideColumnToNotice < ActiveRecord::Migration[8.0]
  def change
    add_column :notices, :is_hide, :boolean, default: false, null: false
  end
end
