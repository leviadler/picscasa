json.(photo, :id, :caption, :album_id, :date_taken, :created_at)
json.tags photo.tags.map {|tag| h(tag.name) }


unless @shallow
  json.image_url photo.image.url(:big)
  json.album_title photo.album.title

  json.owner_id photo.owner.id

  json.already_liked (current_user && current_user.already_liked?(photo)) ? true : false
  json.likes_count photo.likes.to_a.count
  json.view_count photo.view_count

  json.comments photo.comments, partial: 'api/comments/comment', as: :comment
  json.thumb_url photo.image.url(:thumb)
end