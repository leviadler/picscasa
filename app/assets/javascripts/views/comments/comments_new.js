Picscasa.Views.CommentsNew = Backbone.View.extend({
  template: JST["comments/new"],
  
  className: "new-comment",
  
  events: {
    "submit form": "submitComment"
  },
  
  render: function() {
    var renderedContent = this.template({
      photo: this.model
    });
    
    this.$el.html(renderedContent);
    return this;
  },
  
  submitComment: function(event) {
    var view = this;
    event.preventDefault();
    
    var params = $(event.currentTarget).serializeJSON();
    var comment = new Picscasa.Models.PhotoComment(params["comment"]);
    comment.save({}, {
      success: function() {
        $(event.currentTarget)[0].reset();
        view.model.comments().add(comment);
        // view.render()
      }
    })
  }
})