Picscasa.Models.Tag = Backbone.Model.extend({
  initialize: function (options) {
    this.photos();
  },
  
  
  parse: function (response) {
    if (response["photos"]) {
      this.photos().set(response["photos"], { parse: true });
      delete response["photos"];
    }
    return response;
  },

  photos: function () {
    if (!this.get('photos')) {
      var photos = new Picscasa.Subsets.TagPhotos([], {
        parentCollection: Picscasa.allPhotos
      });
      this.set({
        photos: photos
      });
    }
    return this.get('photos');
  }
})