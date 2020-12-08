class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.references :user, foreign_key: true
      t.references :viewing_party, foreign_key: true
      t.timestamps
    end
  end
end
