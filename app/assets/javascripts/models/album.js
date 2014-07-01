Picscasa.Models.Album = Backbone.Model.extend({
  initialize: function () {
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
      var photos = new Picscasa.Subsets.AlbumPhotos([], {
        parentCollection: Picscasa.photos
      });
      this.set({
        photos: photos
      });
    }
    return this.get('photos');
  }
})