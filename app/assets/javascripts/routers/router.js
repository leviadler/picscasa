Picscasa.Routers.Router = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.photos = options.photos;

  },

  routes: {
    "photos" : "photosIndex",
    "photos/:id": "photosShow",
    "albums": "albumsIndex",
    "albums/:id": "albumShow"
  },

  photosIndex: function() {
    Picscasa.helpers.requireSignedIn();
    var indexView = new Picscasa.Views.PhotosIndex({
      collection: this.photos
    });

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

  albumIndex: function() {
    Picscasa.helpers.requireSignedIn();

    var albumIndex = new Picscasa.Views.AlbumsIndex({
      collection: this.albums
    });

    this._swapView(albumIndex);
  },

  _swapView: function (view) {
     this._currentView && this._currentView.remove();
     this._currentView = view;
     this.$rootEl.html(view.render().$el);
   }
})