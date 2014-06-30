Picscasa.Views.PhotoShow = Backbone.View.extend({
  template: JST['photos/show'],

  initialize: function() {

  },

  render: function() {
    var renderedContent = this.template({
      photo: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
})