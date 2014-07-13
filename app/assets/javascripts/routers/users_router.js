Picscasa.Routers.UsersRouter = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "users/:id": "userShow",
  },

  userShow: function(id) {
    var that = this;

    Picscasa.users.getOrFetch(id, function(user) {
      var userShowView = new Picscasa.Views.AlbumsIndex({
        collection: user.albums(),
        title: ((user.id === Picscasa.CURRENT_USER_ID) ? "My" : user.escape("name") + "'s") + " Public Albums",
        user: user,
      });

      that._swapView(userShowView);
    });
  },

  _swapView: function (view) {
     this._currentView && this._currentView.remove();
     this._currentView = view;
     this.$rootEl.html(view.render().$el);
   }

})