Picscasa.Views.PhotoShow = Backbone.View.extend({
  template: JST['photos/show'],

  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function() {
    var renderedContent = this.template({
      photo: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
})