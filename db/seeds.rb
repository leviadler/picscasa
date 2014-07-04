User.create!([
  {email: "demo@picscasa.com", fname: "Levi", lname: "Adler", password_digest: "$2a$10$3EWx3flxb7tV9xr.vWmjA.SAYdvVhKVX9ymFMiiM7n0IJYHQEaYV6", avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, is_activated: nil, activation_token: nil, activation_email_sent_at: nil, provider: nil, uid: nil}
])

Album.create!([
  {title: "Nature", description: "Some lovely pictures of nature", date: "2014-04-01", location: "Kentucky", owner_id: 2, visibility: 2, auth_token: nil}
])

Photo.create!([
  {caption: nil, image_file_name: "data.jpeg", image_content_type: "image/jpeg", image_file_size: 2006912, image_updated_at: "2014-07-04 04:47:28", album_id: 1, date_taken: nil, view_count: 0, ord: nil},
  {caption: nil, image_file_name: "data.jpeg", image_content_type: "image/jpeg", image_file_size: 2455106, image_updated_at: "2014-07-04 04:47:34", album_id: 1, date_taken: "2012-05-26 12:34:20", view_count: 2, ord: nil},
  {caption: nil, image_file_name: "data.jpeg", image_content_type: "image/jpeg", image_file_size: 429772, image_updated_at: "2014-07-04 04:47:20", album_id: 1, date_taken: nil, view_count: 1, ord: nil},
  {caption: nil, image_file_name: "data.jpeg", image_content_type: "image/jpeg", image_file_size: 1293449, image_updated_at: "2014-07-04 04:47:24", album_id: 1, date_taken: nil, view_count: 1, ord: nil},
  {caption: nil, image_file_name: "data.png", image_content_type: "image/png", image_file_size: 3666150, image_updated_at: "2014-07-04 04:47:41", album_id: 1, date_taken: nil, view_count: 3, ord: nil},
  {caption: nil, image_file_name: "data.jpeg", image_content_type: "image/jpeg", image_file_size: 2241086, image_updated_at: "2014-07-04 04:58:52", album_id: 1, date_taken: nil, view_count: 4, ord: nil},
  {caption: nil, image_file_name: "data.jpeg", image_content_type: "image/jpeg", image_file_size: 2006912, image_updated_at: "2014-07-04 05:00:55", album_id: 1, date_taken: nil, view_count: 2, ord: nil}
])


