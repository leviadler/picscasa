 Picscasa.Views.CaptionShow = Backbone.View.extend({
  template: function () {
    return this.open ? JST["photos/edit_caption"] : JST["photos/show_caption"];
  },

  initialize: function (options) {
     this.open = false;
     //this.listenTo(this.model, "change", this.render);
   },

   events: {
     "click #edit-caption": "openForm",
     "submit form": "submitCaption"
   },

  render: function() {
    var renderedContent = this.template()({
      photo: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  openForm: function(event) {
    event.preventDefault();
    this.open = true;
    this.render();
  },

  submitCaption: function(event) {
    event.preventDefault();
    this.open = false;

    var params = $(event.currentTarget).serializeJSON();
    this.model.set(params["photo"]);
    this.model.save();

    this.render();
  }
})