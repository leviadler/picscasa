window.Picscasa = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // bootstrap this later with users album index
    Picscasa.photos = new Picscasa.Collections.Photos()
    new Picscasa.Routers.Router({
      $rootEl: $('main'),
      photos: Picscasa.photos
    });
    Backbone.history.start();
  },
  helpers: {
    signedIn: function() {
      return Picscasa.CURRENT_USER_ID
    },
    canEdit: function(model){
      return Picscasa.CURRENT_USER_ID && (model.get("owner_id") || model.get("user_id")) === Picscasa.CURRENT_USER_ID
    },
    requireSignedIn: function() {
      if (!Picscasa.CURRENT_USER_ID) {
        window.location = '/session/new';
      }
    }
  }
};

$(document).ready(function(){
  Picscasa.initialize();
});
