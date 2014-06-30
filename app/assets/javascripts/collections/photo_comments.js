Picscasa.Collections.PhotoComments = Backbone.Collection.extend({
  initialize: function(options) {
    this.photo = options.photo;
  },
  
  model: Picscasa.Models.PhotoComment,
  
  url: function() {
    return this.photo.url() + "/comments"
  }
})