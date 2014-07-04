Picscasa.Collections.Photos = Backbone.Collection.extend({
  model: Picscasa.Models.Photo,

  url: 'api/photos',

  getOrFetch: function (id, callback) {
    var photos = this;
    var photo = this.get(id);

    if (!photo) {
      photo = new this.model({
        id: id
      });
      photo.collection = photos;
      photo.fetch({
        success: function () {
          photos.add(photo);
          callback(photo);
        }
      });
    } else {
      // fetch in background for comment and like changes
      photo.fetch();
      callback(photo);
    }
  },

  // next: function(model) {
//       var i = this.at(this.indexOf(model));
//       if (undefined === i || i < 0) return false;
//       return this.at(this.indexOf(model) + 1);
//   },
//   prev: function(model) {
//       if (undefined === i || i < 1) return false;
//       return this.at(this.indexOf(model) - 1);
//   }
})