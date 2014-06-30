json.(comment, :id, :body)
json.name comment.user.name
json.avatar_url comment.user.avatar.url(:thumb)