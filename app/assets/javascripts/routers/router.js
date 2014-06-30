Picscasa.Routers.Router = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.allPhotos = options.allPhotos;

  },

  routes: {
    "photos" : "photosIndex",
    "photos/:id": "photosShow"
  },

  photosIndex: function() {
    var indexView = new Picscasa.Views.PhotosIndex({
      collection: this.allPhotos
    });
    console.log(this.allPhotos)
    this.allPhotos.fetch()
    this._swapView(indexView);
  },

  photosShow: function(id) {
    var photo = this.allPhotos.getOrFetch(id);

    var showView = new Picscasa.Views.PhotoShow({
      model: photo,
      collection: this.allPhotos
    });

    this._swapView(showView);
  },



  _swapView: function (view) {
     this._currentView && this._currentView.remove();
     this._currentView = view;
     this.$rootEl.html(view.render().$el);
   }
})