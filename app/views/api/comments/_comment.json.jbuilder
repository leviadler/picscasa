json.(comment, :id, :body, :user_id, :photo_id, :created_at)
json.user_name comment.user.name
json.avatar_url comment.user.avatar.url(:thumb)