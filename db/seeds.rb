Album.create!([
  {title: "sdfdfhsdfh", description: nil, date: "2014-06-04", location: "", owner_id: 1, visibility: 0, auth_token: nil},
  {title: "Apt 2", description: nil, date: "2014-06-10", location: "", owner_id: 1, visibility: 1, auth_token: "Ywm-BkNL8ZIw6mD7wJ38B6WiscTam3O1VOsEQGexLfk"},
  {title: "Apt 1", description: nil, date: "2014-06-08", location: "", owner_id: 1, visibility: 2, auth_token: nil}
])
Photo.create!([
  {caption: nil, image_file_name: "100_2927.JPG", image_content_type: "image/jpeg", image_file_size: 186360, image_updated_at: "2014-06-26 18:08:48", album_id: 3, date_taken: "2009-07-28 20:48:30", view_count: 0, ord: nil},
  {caption: nil, image_file_name: "100_2926.JPG", image_content_type: "image/jpeg", image_file_size: 306423, image_updated_at: "2014-06-26 18:08:45", album_id: 3, date_taken: "2009-07-28 19:22:43", view_count: 2, ord: nil},
  {caption: nil, image_file_name: "100_2929.JPG", image_content_type: "image/jpeg", image_file_size: 259291, image_updated_at: "2014-06-26 18:36:39", album_id: 4, date_taken: "2009-07-28 20:48:46", view_count: 0, ord: nil},
  {caption: nil, image_file_name: "100_2931.JPG", image_content_type: "image/jpeg", image_file_size: 135657, image_updated_at: "2014-06-26 18:36:40", album_id: 4, date_taken: "2009-07-28 20:49:20", view_count: 0, ord: nil},
  {caption: nil, image_file_name: "100_2929.JPG", image_content_type: "image/jpeg", image_file_size: 259291, image_updated_at: "2014-06-26 18:54:46", album_id: 4, date_taken: "2009-07-28 20:48:46", view_count: 0, ord: nil},
  {caption: nil, image_file_name: "100_2934.JPG", image_content_type: "image/jpeg", image_file_size: 188812, image_updated_at: "2014-06-26 18:54:49", album_id: 4, date_taken: "2009-07-28 20:50:06", view_count: 0, ord: nil},
  {caption: nil, image_file_name: "100_2928.JPG", image_content_type: "image/jpeg", image_file_size: 163020, image_updated_at: "2014-06-26 18:08:48", album_id: 3, date_taken: "2009-07-28 20:48:36", view_count: 4, ord: nil},
  {caption: nil, image_file_name: "100_2932.JPG", image_content_type: "image/jpeg", image_file_size: 242362, image_updated_at: "2014-06-26 18:54:48", album_id: 4, date_taken: "2009-07-28 20:49:43", view_count: 10, ord: nil},
  {caption: "    \r\n  ", image_file_name: "100_2930.JPG", image_content_type: "image/jpeg", image_file_size: 160042, image_updated_at: "2014-06-26 18:36:40", album_id: 4, date_taken: "2009-07-28 20:49:07", view_count: 5, ord: nil},
  {caption: "    \r\n  Hey look! Its tiles!", image_file_name: "100_2933.JPG", image_content_type: "image/jpeg", image_file_size: 501308, image_updated_at: "2014-06-26 18:54:48", album_id: 4, date_taken: "2009-07-28 20:49:51", view_count: 5, ord: nil}
])
PhotoTagging.create!([
  {photo_id: 6, tag_id: 1},
  {photo_id: 6, tag_id: 2}
])
Tag.create!([
  {name: "some tag"},
  {name: "another tag"}
])

User.create!([
  {email: "leviadler@gmail.com", fname: "Levi", lname: "Adler", password_digest: "$2a$10$s1NGzU.CRucPhgKbbWB8yO81OQktoKTNV83CUag58M3t0OWGWfrO6", avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, is_activated: nil, activation_token: nil, activation_email_sent_at: nil, provider: nil, uid: nil}
])
