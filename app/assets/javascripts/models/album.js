Picscasa.Models.Album = Backbone.Model.extend({
  initialize: function (options) {
    this.photos();
  },

  url: function() {
    if(this.auth_token) {
      return "api/albums/" + this.id + "/?auth_token=" + this.auth_token;
    } else if(this.isNew()) {
      return "api/albums"
    } else {
      return "api/albums/" + this.id
    }
  },
  
  // namespace params and remove nested
  toJSON: function() {
    var attr = _.clone( this.attributes );
    delete attr.photos;
    return { album: attr }
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