json.(@user, :id, :name)
json.avatar_thumb_url @user.avatar.url(:thumb)
json.albums @public_albums, partial: 'api/albums/album', as: :album