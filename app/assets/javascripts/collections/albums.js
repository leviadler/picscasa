Picscasa.Collections.Albums = Backbone.Collection.extend({
  url: "albums",

  model: Picscasa.Models.Album,

  getOrFetch: function (id, callback) {
    var albums = this;
    var album = this.get(id);

    if (!album) {
      console.log("fetching");
      album = new this.model({
        id: id
      });
      album.collection = albums;
      album.fetch({
        success: function () {
          albums.add(album);
          callback(album);
        }
      });
    } else {
      callback(album);
    }
  }


})