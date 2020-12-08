class RenameViewingPartiesColumnToParties < ActiveRecord::Migration[5.2]
  def change
    rename_column :guests, :viewing_party_id, :party_id
  end
end
