Picscasa.Routers.Router = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.photos = options.photos;
    this.albums = options.albums
  },

  routes: {
    "photos" : "photosIndex",
    "photos/:id": "photosShow",
    "albums": "albumsIndex",
    "albums/public": "publicAlbums",
    "albums/:id": "albumShow"
  },

  photosIndex: function() {
    Picscasa.helpers.requireSignedIn();
    var indexView = new Picscasa.Views.PhotosIndex({
      collection: this.photos
    });

    // do we get rid of this when bootrapping?
    this.photos.fetch()
    this._swapView(indexView);
  },

  photosShow: function(id) {
    var that = this;

    this.photos.getOrFetch(id, function(photo) {
      var showView = new Picscasa.Views.PhotoShow({
        model: photo,
        collection: that.photos
      });

      that._swapView(showView);
    });


  },

  albumsIndex: function() {
    Picscasa.helpers.requireSignedIn();

    var albumIndex = new Picscasa.Views.AlbumsIndex({
      collection: this.albums
    });

    // do we get rid of this when bootrapping?
    this.albums.fetch()

    this._swapView(albumIndex);
  },


  albumsIndex: function() {
    Picscasa.helpers.requireSignedIn();

    var albumIndex = new Picscasa.Views.AlbumsIndex({
      collection: this.albums
    });

    // do we get rid of this when bootrapping?
    this.albums.fetch()

    this._swapView(albumIndex);
  },

  albumShow: function(id) {
    var that = this;

    this.albums.getOrFetch(id, function(album) {
      var showView = new Picscasa.Views.AlbumShow({
        model: album,
        collection: that.albums
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