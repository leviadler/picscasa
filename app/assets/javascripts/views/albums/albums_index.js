Picscasa.Views.AlbumsIndex = Backbone.View.extend({
  template: JST["albums/index"],

  initialize: function() {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function() {
    var renderedContent = this.template({
      albums: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
})