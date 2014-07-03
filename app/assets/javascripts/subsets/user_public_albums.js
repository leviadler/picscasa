Picscasa.Subsets.UserPublicAlbums = Backbone.Subset.extend({
  comparator: function(album) {
    return (new Date()) - (new Date(album.get('created_at')));
  }
})