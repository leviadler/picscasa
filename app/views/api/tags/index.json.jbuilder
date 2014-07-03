json.array! @tags do |tag|
  json.id tag.id
  json.name h(tag.name)
  json.photo_count tag.photo_count
end