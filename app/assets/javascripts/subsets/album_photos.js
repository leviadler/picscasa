Picscasa.Subsets.AlbumPhotos = Backbone.Subset.extend({
  url: "photos",

  comparator: function(photo) {
    return photo.get('created_at');
  },

  next: function(model) {
    var i = this.at(this.indexOf(model));
    if (undefined === i || i < 0) return false;
    return this.at(this.indexOf(model) + 1);
  },
  prev: function(model) {
    var i = this.at(this.indexOf(model));
    if (undefined === i || i < 1) return false;
    return this.at(this.indexOf(model) - 1);
  }
})