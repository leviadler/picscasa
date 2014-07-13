Picscasa.Routers.IndexRouter = Backbone.Router.extend({

  routes: {
    "": "index",
    '*notFound': "index"
  },

  index: function() {
    Backbone.history.navigate("#/photos", {trigger: true})
  }
})