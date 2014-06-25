class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :caption
      t.attachment :image
      t.integer :album_id
      t.datetime :date_taken

      t.timestamps
    end
    add_index :photos, :album_id
  end
end
