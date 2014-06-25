class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :caption
      t.attachment :image
      t.integer :album_id
      t.datetime :date_taken
      t.integer :view_count, default: 0
      t.float :ord

      t.timestamps
    end
    add_index :photos, :album_id
    add_index :photos, :view_count
    add_index :photos, :ord
  end
end
