Picscasa.Subsets.TagPhotos = Backbone.Subset.extend({
  url: "photos",
  
  comparator: function(photo) {
    return photo.get('created_at');
  }
})