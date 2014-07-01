Picscasa.Views.AlbumShow = Backbone.View.extend({
  template: JST["albums/show"],

  render: function() {
    var renderedContent = this.template({
      album: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
})