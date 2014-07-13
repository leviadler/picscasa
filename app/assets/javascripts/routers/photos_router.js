Picscasa.Routers.PhotosRouter = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "photos" : "photosIndex",
    "photos/:id": "photosShow",
  },

  photosIndex: function() {
    Picscasa.helpers.requireSignedIn();
    var indexView = new Picscasa.Views.PhotosIndex({
      collection: Picscasa.userPhotos,
      title: "My Photos"
    });

    // removed when bootstrapping:
    //Picscasa.userPhotos.fetch()
    this._swapView(indexView);
  },

  photosShow: function(id) {
    var that = this;

    Picscasa.allPhotos.getOrFetch(id, function(photo) {
      var showView = new Picscasa.Views.PhotoShow({
        model: photo,
        //collection: Picscasa.userPhotos
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