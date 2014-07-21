Picscasa.Routers.AlbumsRouter = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl
  },

  routes: {
    "albums": "albumsIndex",
    "albums/new": "newAlbum",
    "albums/:id/edit": "editAlbum",
    "albums/:id/upload": "imageUpload",
    "albums/:id/share": "shareAlbum",
    "albums/public": "publicAlbums",
    "albums/:id/auth_token/:auth_token": "unlistedAlbumShow",
    "albums/:id": "albumShow"
  },

  albumsIndex: function() {
    Picscasa.helpers.requireSignedIn();

    var albumIndexView = new Picscasa.Views.AlbumsIndex({
      collection: Picscasa.userAlbums,
      title: "My Albums"
    });

    // do we get rid of this when bootrapping?
    // remove if paginating?
    // Picscasa.userAlbums.fetch()

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

    var publicAlbumView = new Picscasa.Views.AlbumsIndex({
      collection: Picscasa.publicAlbums,
      title: "Public Albums"
    });

    // don't need this b/c bootstrapping but still
    // do it in case public albums changes
    // TODO remove if paginating!
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

  shareAlbum: function(id) {
    var that = this;

    Picscasa.allAlbums.getOrFetch(id, function(album) {
      if (!Picscasa.helpers.requireOwner(album) ||
          album.get("visibility") === "private_album") {
            return
          };

      var shareView = new Picscasa.Views.AlbumShare({
        model: album,
      });

      that._swapView(shareView);
    });

  },

  unlistedAlbumShow: function(id, auth_token) {
    var that = this;

    var album = new Picscasa.Models.Album({id: id});
    album.auth_token = auth_token

    album.fetch({
      success: function(album) {
        Picscasa.allAlbums.add(album);
        var showView = new Picscasa.Views.AlbumShow({
          model: album
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