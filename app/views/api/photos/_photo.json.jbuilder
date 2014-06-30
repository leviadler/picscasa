json.(photo, :id, :caption, :album_id, :date_taken, :created_at)
json.image_url photo.image.url(:big)
json.album_title photo.album.title
json.can_edit true if photo.owner == current_user
json.can_like true if signed_in?
json.already_liked true if (current_user && current_user.already_liked?(photo))

json.tags photo.tags
json.comments photo.comments, partial: 'api/comments/comment', as: :comment
json.thumb_url photo.image.url(:thumb)