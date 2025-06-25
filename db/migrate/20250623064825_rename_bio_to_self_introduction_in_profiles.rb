class RenameBioToSelfIntroductionInProfiles < ActiveRecord::Migration[8.0]
  def change
    rename_column :profiles, :bio, :self_introduction
  end
end
