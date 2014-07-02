Picscasa.Routers.Router = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    //"": "index",
    "photos" : "photosIndex",
    "photos/:id": "photosShow",
    "albums": "albumsIndex",
    "albums/new": "newAlbum",
    "albums/:id/edit": "editAlbum",
    "albums/:id/upload": "imageUpload",
    "albums/public": "publicAlbums",
    "albums/:id/auth_token/:auth_token": "unlistedAlbumShow",
    "albums/:id": "albumShow"
  },

  // index: function() {
//     Backbone.history.navigate("#/photos", {trigger: true})
//   },

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
      collection: Picscasa.userAlbums,
      title: "My Albums"
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
      collection: Picscasa.publicAlbums,
      title: "Public Albums"
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

  unlistedAlbumShow: function(id, auth_token) {
    var that = this;

    var album = new Picscasa.Models.Album({id: id});
    album.auth_token = auth_token

    album.fetch({
      success: function(album) {
        var showView = new Picscasa.Views.AlbumShow({
          model: album,
          collection: Picscasa.userAlbums
        });

        that._swapView(showView);
      },
      error: function(album, response) {
        Picscasa.helpers.renderFlash(response.responseJSON.join(" - "), "error");
        Picscasa.helpers.requireSignedIn();
      }
    })
  },

  imageUpload: function(id) {
    Picscasa.helpers.requireSignedIn();
    var that = this;

    Picscasa.allAlbums.getOrFetch(id, function(album) {
      if (!Picscasa.helpers.requireOwner(album)) { return };

      var imageUploadView = new Picscasa.Views.NewPhoto({
        model: album,
      });

      that._swapView(imageUploadView);
    });

  },

  _swapView: function (view) {
     this._currentView && this._currentView.remove();
     this._currentView = view;
     this.$rootEl.html(view.render().$el);
   }
})