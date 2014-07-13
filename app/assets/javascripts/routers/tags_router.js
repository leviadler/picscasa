Picscasa.Routers.TagsRouter = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "tags": "tagsIndex",
    "tags/:id": "tagShow"
  },

  tagsIndex: function() {
    Picscasa.userTags.fetch();

    var tagIndexView = new Picscasa.Views.TagsIndex({
      collection: Picscasa.userTags
    });

    this._swapView(tagIndexView);
  },

  tagShow: function(id) {
    var that = this;

    Picscasa.userTags.getAndFetch(id, function(tag) {
      var tagShowView = new Picscasa.Views.PhotosIndex({
        collection: tag.photos(),
        title: "Photos tagged as " + tag.escape("name")
      });

      that._swapView(tagShowView);
    })
  },

  _swapView: function (view) {
     this._currentView && this._currentView.remove();
     this._currentView = view;
     this.$rootEl.html(view.render().$el);
   }

})