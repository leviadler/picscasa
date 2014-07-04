Picscasa.Views.AlbumsForm = Backbone.View.extend({
  template: JST["albums/form"],

  events: {
    'submit form': "submitAlbum"
  },

  render: function() {
    var renderedContent = this.template({
      album: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  submitAlbum: function(event) {
    Picscasa.collection = this.collection;
    event.preventDefault();

    var formData = $(event.currentTarget).serializeJSON();

    var success = function(album) {
      Backbone.history.navigate("#/albums/" + album.id, { trigger: true });
    };

    var error = function(album, response) {
      // not sure which to use
      // should also prob make this a helper that just takes the class name
      // and message sets the other defaults
      // notify js is not responding well to long messages
      // doesn't center them well
      // response.responseJSON.forEach(function(error) {
//         $.notify(error, { className: "error", globalPosition: "top center"});
//       })

      Picscasa.helpers.renderFlash(response.responseJSON.join(" - "), "error");
    }

    this.model.set(formData["album"]);
    console.log(this.model);

    if (this.model.isNew()) {
      this.collection.create(this.model, {
        success: success,
        error: error,
        wait: true,
        sort: true
      });
    } else {
      this.model.save({}, {
        success: success,
        error: error
      });
    }
  }
})