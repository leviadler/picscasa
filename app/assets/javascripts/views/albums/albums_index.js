Picscasa.Views.AlbumsIndex = Backbone.View.extend({
  template: JST["albums/index"],

  initialize: function(options) {
    this.title = options.title;
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function() {
    var renderedContent = this.template({
      albums: this.collection,
      title: this.title
    });

    this.$el.html(renderedContent);
    return this;
  }
})