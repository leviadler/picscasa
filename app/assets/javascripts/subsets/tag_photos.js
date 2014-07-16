Picscasa.Subsets.TagPhotos = Backbone.Subset.extend({
  url: "api/photos",

  comparator: function(photo) {
    return photo.get('created_at');
  }
})