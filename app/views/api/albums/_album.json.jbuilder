json.(album, :id, :title, :description, :date, :location, :owner_id, :visibility, :auth_token, :created_at)
json.date_string album.date.strftime("%b %d, %Y")
json.thumb_url (album.photos.first ? album.photos.first.image.url(:thumb) : image_url("default_album.png"))
json.photo_count album.photos.to_a.count
json.owner_name album.owner.name
json.photos album.photos, partial: 'api/photos/photo', as: :photo