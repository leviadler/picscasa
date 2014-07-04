# maybe change this to a partial
json.array! @photos, partial: 'api/photos/photo', as: :photo

# unsuccessful attempt to make all photos an album so can click next in it
# json.title "My Photos"
# json.id "all"
# json.photos @photos, partial: 'api/photos/photo', as: :photo