window.Picscasa = {
  Models: {},
  Collections: {},
  Subsets: {},
  Views: {},
  Routers: {},
  initialize: function() {

    // bootstrap all this later
    Picscasa.allPhotos = new Picscasa.Collections.Photos()
    Picscasa.allAlbums = new Picscasa.Collections.Albums()
    Picscasa.userPhotos = new Picscasa.Subsets.UserPhotos( [], {
      parentCollection: Picscasa.allPhotos
    })
    Picscasa.userAlbums = new Picscasa.Subsets.UserAlbums([], {
      parentCollection: Picscasa.allAlbums
    })
    Picscasa.publicAlbums = new Picscasa.Subsets.PublicAlbums([], {
      parentCollection: Picscasa.allAlbums
    })

    new Picscasa.Routers.Router({
      $rootEl: $('div#content'),
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
    requireOwner: function(model) {
      if(!Picscasa.helpers.canEdit(model)) {
        $.notify("Access denied", { className: "error", globalPosition: "top center"});
        Backbone.history.navigate("#/photos", {trigger: true});
        return false;
      } else {
        return true;
      }
    },
    requireSignedIn: function() {
      if (!Picscasa.CURRENT_USER_ID) {
        window.location = '/session/new';
      }
    },

    renderFlash: function(message, className) {
      $("div.flash").html(message).removeClass().addClass("flash flash-" + className).show().delay(5000).fadeOut("slow", function(){
        $(this).html("");
      });
    }
  }
};

$(document).ready(function(){
  Picscasa.initialize();
});
