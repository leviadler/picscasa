json.array! @tags do |tag|
  json.id tag.id
  json.name h(tag.name)
  # json.count tag.photo_taggings.to_a.count # not working! gets tag count for all users!
end