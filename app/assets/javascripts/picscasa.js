window.Picscasa = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Picscasa.photos = new Picscasa.Collections.Photos()
    new Picscasa.Routers.Router({
      $rootEl: $('main'),
      photos: Picscasa.photos
    });
    Backbone.history.start();
  },
  helpers: {
    
  }
};

$(document).ready(function(){
  Picscasa.initialize();
});
