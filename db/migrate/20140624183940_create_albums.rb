class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.text :description
      t.date :date
      t.string :location
      t.integer :owner_id
      t.integer :visibility

      t.timestamps
    end
    add_index :albums, :owner_id
  end
end
