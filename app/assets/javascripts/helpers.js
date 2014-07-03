_.extend(Picscasa.helpers, {
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
})