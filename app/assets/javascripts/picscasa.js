window.Picscasa = {
  Models: {},
  Collections: {},
  Subsets: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Picscasa.allPhotos = new Picscasa.Collections.Photos()
    Picscasa.allAlbums = new Picscasa.Collections.Albums()
    
    // get bootsrapped
    var bootstrappedData = JSON.parse($("#bootstrapped-data").html());
    
    if(Picscasa.CURRENT_USER_ID) {
      Picscasa.userPhotos = new Picscasa.Subsets.UserPhotos( bootstrappedData.userPhotos, {
        parentCollection: Picscasa.allPhotos,
        parse: true
      })
      Picscasa.userAlbums = new Picscasa.Subsets.UserAlbums(bootstrappedData.userAlbums, {
        parentCollection: Picscasa.allAlbums,
        parse: true
      })
    }
    
    Picscasa.publicAlbums = new Picscasa.Subsets.PublicAlbums(bootstrappedData.publicAlbums, {
      parentCollection: Picscasa.allAlbums,
      parse: true
    });
    
    Picscasa.users = new Picscasa.Collections.Users({});

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
      $("div.flash-container .flash").html(message).removeClass().addClass("flash flash-" + className).show().delay(5000).fadeOut("slow", function(){
        $(this).html("");
      });
    }
  }
};

$(document).ready(function(){
  Picscasa.initialize();
});
