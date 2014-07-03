Picscasa.Subsets.UserAlbums = Backbone.Subset.extend({
  url: "albums",
  
  comparator: function(album) {
    return (new Date()) - (new Date(album.get('created_at')));
  }
})