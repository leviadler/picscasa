# maybe change this to a partial
# json.array! @photos, partial: 'api/photos/photo', as: :photo

json.title "My Photos"
json.id "all"
json.photos @photos, partial: 'api/photos/photo', as: :photo