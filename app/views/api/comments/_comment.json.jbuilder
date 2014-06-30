json.(comment, :id, :body, :user_id)
json.name comment.user.name
json.avatar_url comment.user.avatar.url(:thumb)