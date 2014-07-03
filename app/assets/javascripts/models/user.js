Picscasa.Models.User = Backbone.Model.extend({
  initialize: function (options) {
    this.albums();
  },

  parse: function (response) {
    if (response["albums"]) {
      this.albums().set(response["albums"], { parse: true });
      delete response["albums"];
    }
    return response;
  },

  albums: function () {
    if (!this.get('albums')) {
      var albums = new Picscasa.Subsets.UserPublicAlbums([], {
        parentCollection: Picscasa.publicAlbums
      });
      this.set({
        albums: albums
      });
    }
    return this.get('albums');
  },
  
  // namespace params and remove nested
  toJSON: function() {
    var attr = _.clone( this.attributes );
    delete attr.albums;
    return { user: attr }
  },
})