Picscasa.Models.Album = Backbone.Model.extend({
  initialize: function (options) {
    this.photos();
  },

  url: function() {
    if(this.auth_token) {
      return "albums/" + this.id + "/?auth_token=" + this.auth_token;
    } else if(this.isNew()) {
      return "albums" 
    } else {
      return "albums/" + this.id
    }
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
        parentCollection: Picscasa.allPhotos
      });
      this.set({
        photos: photos
      });
    }
    return this.get('photos');
  }
})