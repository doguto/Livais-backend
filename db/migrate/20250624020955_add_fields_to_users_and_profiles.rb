class AddFieldsToUsersAndProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :cover_image, :string
  end
end
