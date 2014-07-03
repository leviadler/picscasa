json.(album, :id, :title, :description, :date, :location, :owner_id, :visibility, :created_at)

if album.owner == current_user
  if album.unlisted_album?
    json.share_url "#{root_url}#/albums/#{album.id}/auth_token/#{album.auth_token}"
  elsif album.public_album?
    json.share_url "#{root_url}#/albums/#{album.id}"
  end
end

unless @shallow
  json.date_string album.date.strftime("%b %d, %Y")

  photos =  album.photos.sort_by {|photo| photo.created_at}
  json.thumb_url (photos.first ? photos.first.image.url(:thumb) : image_url("default_album.png"))
  json.photo_count album.photos.to_a.count
  json.owner_name album.owner.name
  json.photos album.photos, partial: 'api/photos/photo', as: :photo
end