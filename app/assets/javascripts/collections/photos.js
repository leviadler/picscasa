Picscasa.Collections.Photos = Backbone.Collection.extend({
  model: Picscasa.Models.Photo,

  url: 'photos',

  getOrFetch: function (id, callback) {
    var photos = this;
    var photo = Picscasa.photos.get(id);

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
      callback(photo);
    }
  }
})