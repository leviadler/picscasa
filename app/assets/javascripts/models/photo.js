Picscasa.Models.Photo = Backbone.Model.extend({
  initialize: function () {
    this.comments();
  },

  urlRoot: "api/photos",

  parse: function (response) {
    if (response["comments"]) {
      this.comments().set(response["comments"], { parse: true });
      delete response["comments"];
    }
    return response;
  },

  comments: function () {
    if (!this.get('comments')) {
      var photoComments = new Picscasa.Collections.PhotoComments([], {
        photo: this
      });
      this.set({
        comments: photoComments
      });
    }
    return this.get('comments');
  }, 
  
  // namespace params and remove nested
  toJSON: function() {
    var attr = _.clone( this.attributes );
    delete attr.comments;
    return { photo: attr }
  },
})