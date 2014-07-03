Picscasa.Views.NewPhoto = Backbone.View.extend({
  template: JST["photos/new"],

  initialize: function(options) {
  },

  events: {
    // "dragenter #dropzone": "dragenter",
    // "dragover #dropzone": "dragover",
    // "drop #dropzone": "drop",

    "submit form": "uploadImages"
  },

  render: function() {
    var renderedContent = this.template({
      album: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },


  // dragenter: function(event) {
  //   event.stopPropagation();
  //   event.preventDefault();
  // },
  //
  // dragover: function(event) {
  //   event.stopPropagation();
  //   event.preventDefault();
  // },
  //
  // drop: function(event) {
  //   event.stopPropagation();
  //   event.preventDefault();
  //
  //   var dt = event.dataTransfer;
  //   var files = dt.files;
  //
  //   handleFiles(files);
  // },


  uploadImages: function(event) {
    var that = this;

    event.preventDefault();
    var input = $(event.currentTarget).find("#photo_images")

    var files = input[0].files;

    if (files.length === 0) {
      Picscasa.helpers.renderFlash("Please choose a valid file", "error");
      return;
    }

    input.attr("disabled", "disabled");
    $("input[type=submit]").attr("disabled", "disabled").addClass("disabled");


    // forward immediately and pics will appear as uploaded
    // prob not very good for error checking
    Backbone.history.navigate("#/albums/" + that.model.id, {trigger: true})
    Picscasa.helpers.renderFlash("Photos Uploading...", "success");

    for(var i = 0; i < files.length; i++) {
      var file = files[i];

      var reader = new FileReader();
      reader.onload = function(event) {
        var photo = new Picscasa.Models.Photo();
        photo.set({image: this.result, album_id: that.model.id});
        photo.save({}, {
          success: function(photo) {
            that.model.photos().add(photo);
            photo.set({image: null}); // so that the whole image is not saved as an attribute with every model uploaded.
            // Backbone.history.navigate("#/albums/" + that.model.id, {trigger: true})
            console.log(photo);
          },
          error: function(photo, response) {
            Picscasa.helpers.renderFlash(response.responseJSON.join(" - "), "error");
          }
        });
      }

      reader.readAsDataURL(file);
    }

  }

})

