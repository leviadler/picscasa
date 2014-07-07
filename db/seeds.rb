users = User.create!([
  {email: "demo@picscasa.com", fname: "Levi", lname: "Adler", password: "foobar"},
  {email: "john@example.com", fname: "John", lname: "Doe", password: "password1"},
  {email: "jim@example.com", fname: "Jim", lname: "Guraury", password: "password1"},
  {email: "fred@example.com", fname: "Fred", lname: "Freedman", password: "password1"},
  {email: "dan@example.com", fname: "Dan", lname: "Theman", password: "password1"}
])

Album.create!([
  {title: "Nature", description: "Some lovely pictures of nature", date: "2014-04-01", location: "Kentucky", owner_id: 1, visibility: 2, auth_token: nil},
  {title: "Vacation", description: "Vacation Pictures", date: "2014-04-01", location: "Texas", owner_id: 1, visibility: 1, auth_token: nil},
  {title: "Having Fun", description: "Just having some fun", date: "2014-04-01", location: "Florida", owner_id: 1, visibility: 0, auth_token: nil}
  
  {title: "Good Times", description: "Some lovely pictures of nature", date: "2014-03-01", location: "Georgia", owner_id: 2, visibility: 2, auth_token: nil},
  {title: "Best Party Ever!", description: "Vacation Pictures", date: "2014-02-05", location: "Texas", owner_id: 2, visibility: 1, auth_token: nil},
  {title: "Graduation Party", description: "Just having some fun", date: "2014-01-03", location: "Florida", owner_id: 2, visibility: 0, auth_token: nil}
  
  # {title: "Nature", description: "Some lovely pictures of nature", date: "2014-04-01", location: "Kentucky", owner_id: 3, visibility: 2, auth_token: nil},
#   {title: "Vacation", description: "Vacation Pictures", date: "2014-04-01", location: "Texas", owner_id: 3, visibility: 1, auth_token: nil},
#   {title: "Having Fun", description: "Just having some fun", date: "2014-04-01", location: "Florida", owner_id: 3, visibility: 0, auth_token: nil}
#
#   {title: "Nature", description: "Some lovely pictures of nature", date: "2014-04-01", location: "Kentucky", owner_id: 4, visibility: 2, auth_token: nil},
#   {title: "Vacation", description: "Vacation Pictures", date: "2014-04-01", location: "Texas", owner_id: 4, visibility: 1, auth_token: nil},
#   {title: "Having Fun", description: "Just having some fun", date: "2014-04-01", location: "Florida", owner_id: 4, visibility: 0, auth_token: nil}
#
#   {title: "Nature", description: "Some lovely pictures of nature", date: "2014-04-01", location: "Kentucky", owner_id: 5, visibility: 2, auth_token: nil},
#   {title: "Vacation", description: "Vacation Pictures", date: "2014-04-01", location: "Texas", owner_id: 5, visibility: 1, auth_token: nil},
#   {title: "Having Fun", description: "Just having some fun", date: "2014-04-01", location: "Florida", owner_id: 5, visibility: 0, auth_token: nil}
])

Photo.create!([
  {album_id: 2, caption: "Barn in the mountains", image: "https://farm4.staticflickr.com/3701/14250671936_d7e582e811_b.jpg"},
  {album_id: 2, caption: "Walking to the Rocher Percé. Gaspésie. #1", image: "https://farm6.staticflickr.com/5528/14087246028_8bcef0274b_b.jpg"},
  {album_id: 2, caption: "Kayaking in the clouds.", image: "https://farm4.staticflickr.com/3740/14276682652_e3927c2729_b.jpg"},
  {album_id: 2, caption: "Kerry Park Moonrise", image: "https://farm3.staticflickr.com/2901/14277653074_438d452106_b.jpg"},
  {album_id: 2, caption: "City That Never Sleeps", image: "https://farm6.staticflickr.com/5235/14295537173_dbc08a7451_b.jpg"},
  {album_id: 3, caption: "Let Sleeping Owls Lie", image: "https://farm4.staticflickr.com/3733/14273811504_70e8b44fab_b.jpg"},
  {album_id: 3, caption: "sunset - Powell Point - Grand Canyon - 5-09-14  01", image: "https://farm3.staticflickr.com/2929/14272300182_1c2a7abdd3_b.jpg"},
  {album_id: 3, caption: "Sticks and Stones...", image: "https://farm6.staticflickr.com/5594/14270932402_ac259f23d2_b.jpg"},
  {album_id: 3, caption: "Kitty Portrait", image: "https://farm4.staticflickr.com/3750/14273400454_90fe2c5020_b.jpg"},
  {album_id: 1, caption: "Entrance to another World .....", image: "https://farm3.staticflickr.com/2909/14301641103_01bd21aa09_b.jpg"},
  {album_id: 1, caption: "Swedish Royal Castle shot from Skeppsholmen (Stockholm)", image: "https://farm6.staticflickr.com/5491/14097130247_ab25b41b44_b.jpg"},
  {album_id: 1, caption: "un sogno ricorrente - a recurring dream", image: "https://farm3.staticflickr.com/2896/14094879910_b02fa8f727_b.jpg"},
  {album_id: 1, caption: "Blue lake", image: "http://www.wallsave.com/wallpapers/1024x640/smooking/34363/smooking-free-stock-p-os-images-part-34363.jpg"},
  {album_id: 1, caption: "Kids at Play", image: "https://farm4.staticflickr.com/3720/14283762224_74f78d9e7e_b.jpg"},
  {album_id: 1, caption: "Follow the Willow Road", image: "https://farm4.staticflickr.com/3668/14282863671_a8d25598ae_b.jpg"},
  {album_id: 1, caption: "JRG+JRB", image: "https://farm4.staticflickr.com/3785/14096661038_22efebe5a6_b.jpg"},
  {album_id: 1, caption: "Vegas", image: "https://farm6.staticflickr.com/5312/14285015905_2749114ebe_b.jpg"},
  {album_id: 1, caption: "10.22am sunday, this is why i get up early, to avoid the rush", image: "https://farm4.staticflickr.com/3713/14259181396_889d7ac369_b.jpg"},
  {album_id: 1, caption: "Selfoss Iceland", image: "https://farm6.staticflickr.com/5114/14098937919_c0f192aa8d_b.jpg"},
  {album_id: 1, caption: "Taxi Omotesando", image: "https://farm6.staticflickr.com/5538/14281097251_5d20a93c87_b.jpg"},
  {album_id: 1, caption: "San Pietro", image: "https://farm3.staticflickr.com/2926/14099696077_1e8a146b17_b.jpg"},
  {album_id: 3, caption: "Wahclella Falls", image: "https://farm6.staticflickr.com/5113/14113080137_d6cec1dbca_b.jpg"}
])

# require 'flickr'
# flickr = Flickr.new(
#   ENV['FLICKR_KEY']
# )
# recentphotos = flickr.photos
# useful is .source == the url - .description == my captions

