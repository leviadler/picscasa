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
    $("input[type=submit]").attr("disabled", "disabled").addClass("disabled").val("    Uploading...   ");


    for(var i = 0; i < files.length; i++) {
      var file = files[i];

      var reader = new FileReader();
      reader.onload = function(e) {
        var photo = new Picscasa.Models.Photo();
        photo.set({photo: {image: this.result, album_id: that.model.id}});
        photo.save({}, {
          success: function(photo) {
            that.model.photos().add(photo);
            Backbone.history.navigate("#/albums/" + that.model.id, {trigger: true})
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

