window.Picscasa = {
  Models: {},
  Collections: {},
  Subsets: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // bootstrap this later with users album index
    Picscasa.photos = new Picscasa.Collections.Photos()
    Picscasa.albums = new Picscasa.Collections.Albums()
    // duplicate data - should prob have a allAlbums collection
    // and have users albums, users pubic albums and public albums
    // be a subset of it.
    Picscasa.publicAlbums = new Picscasa.Collections.PublicAlbums()
    new Picscasa.Routers.Router({
      $rootEl: $('main'),
      photos: Picscasa.photos,
      albums: Picscasa.albums,
      publicAlbums: Picscasa.publicAlbums
    });
    Backbone.history.start();
  },
  helpers: {
    signedIn: function() {
      return Picscasa.CURRENT_USER_ID
    },
    canEdit: function(model){
      return Picscasa.CURRENT_USER_ID && (model.get("owner_id") || model.get("user_id")) === Picscasa.CURRENT_USER_ID
    },
    requireSignedIn: function() {
      if (!Picscasa.CURRENT_USER_ID) {
        window.location = '/session/new';
      }
    }
  }
};

$(document).ready(function(){
  Picscasa.initialize();
});
