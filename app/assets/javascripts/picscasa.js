window.Picscasa = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Picscasa.photos = new Picscasa.Collections.Photos()
    new Picscasa.Routers.Router({
      $rootEl: $('main'),
      allPhotos: Picscasa.photos
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Picscasa.initialize();
});
