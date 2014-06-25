class AddAuthTokentoAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :auth_token, :string
  end
end
