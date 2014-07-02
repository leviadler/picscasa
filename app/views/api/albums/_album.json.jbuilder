json.(album, :id, :title, :description, :date, :location, :owner_id, :visibility, :created_at)
json.auth_token album.auth_token if album.owner == current_user
json.date_string album.date.strftime("%b %d, %Y")

photos =  album.photos.sort_by {|photo| photo.created_at}
json.thumb_url (photos.first ? photos.first.image.url(:thumb) : image_url("default_album.png"))
json.photo_count album.photos.to_a.count
json.owner_name album.owner.name
json.photos album.photos, partial: 'api/photos/photo', as: :photo