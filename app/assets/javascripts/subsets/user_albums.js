Picscasa.Subsets.UserAlbums = Backbone.Subset.extend({
  url: "api/albums",

  comparator: function(album) {
    return (new Date()) - (new Date(album.get('created_at')));
  }
})