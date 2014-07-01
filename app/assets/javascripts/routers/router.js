Picscasa.Routers.Router = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "index",
    "photos" : "photosIndex",
    "photos/:id": "photosShow",
    "albums": "albumsIndex",
    "albums/new": "newAlbum",
    "albums/:id/edit": "editAlbum",
    "albums/public": "publicAlbums",
    "albums/:id": "albumShow"
  },

  index: function() {
    Backbone.history.navigate("#/photos", {trigger: true})
  },

  photosIndex: function() {
    Picscasa.helpers.requireSignedIn();
    var indexView = new Picscasa.Views.PhotosIndex({
      collection: Picscasa.userPhotos
    });

    // do we get rid of this when bootrapping?
    Picscasa.userPhotos.fetch()
    this._swapView(indexView);
  },

  photosShow: function(id) {
    var that = this;

    Picscasa.allPhotos.getOrFetch(id, function(photo) {
      var showView = new Picscasa.Views.PhotoShow({
        model: photo,
        collection: Picscasa.userPhotos
      });

      that._swapView(showView);
    });


  },

  albumsIndex: function() {
    Picscasa.helpers.requireSignedIn();

    var albumIndexView = new Picscasa.Views.AlbumsIndex({
      collection: Picscasa.userAlbums
    });

    // do we get rid of this when bootrapping?
    Picscasa.userAlbums.fetch()

    this._swapView(albumIndexView);
  },

  newAlbum: function() {
    Picscasa.helpers.requireSignedIn();

    newAlbum = new Picscasa.Models.Album();
    var newAlbumView = new Picscasa.Views.AlbumsForm({
      collection: Picscasa.userAlbums,
      model: newAlbum
    });

    this._swapView(newAlbumView);
  },

  editAlbum: function(id) {
    Picscasa.helpers.requireSignedIn();

    var that = this;

    Picscasa.allAlbums.getOrFetch(id, function(album) {
      if (!Picscasa.helpers.requireOwner(album)) { return };

      var editAlbumView = new Picscasa.Views.AlbumsForm({
        collection: Picscasa.userAlbums,
        model: album
      });

      that._swapView(editAlbumView);
    });

  },


  publicAlbums: function() {
    Picscasa.helpers.requireSignedIn();

    var publicAlbumView = new Picscasa.Views.AlbumsIndex({
      collection: Picscasa.publicAlbums
    });

    // do we get rid of this when bootrapping?
    Picscasa.publicAlbums.fetch()

    this._swapView(publicAlbumView);
  },

  albumShow: function(id) {
    var that = this;

    Picscasa.allAlbums.getOrFetch(id, function(album) {
      var showView = new Picscasa.Views.AlbumShow({
        model: album,
        collection: Picscasa.userAlbums
      });

      that._swapView(showView);
    });


  },

  _swapView: function (view) {
     this._currentView && this._currentView.remove();
     this._currentView = view;
     this.$rootEl.html(view.render().$el);
   }
})