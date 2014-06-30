Picscasa.Views.PhotosIndex = Backbone.View.extend({
  template: JST['photos/index'],

  initialize: function() {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function() {
    var renderedContent = this.template({
      photos: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
})