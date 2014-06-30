Picscasa.Collections.Photos = Backbone.Collection.extend({
  model: Picscasa.Models.Photo,

  url: 'photos',

  getOrFetch: function (id) {
   var photos = this;

   var photo = this.get(id);
   if (!(photo)) {
     photo = new Picscasa.Models.Photo({ id: id });
     photo.fetch({
       success: function () {
         photos.add(photo);
         return photo;
       }
     });
   } else {
     return photo;
   }
  }
})