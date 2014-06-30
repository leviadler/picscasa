Picscasa.Views.CommentsShow = Backbone.View.extend({
  template: JST['comments/show'],
  
  className: "comment group",
  
  events: {
    "submit .delete-comment" : "deleteComment"
  }, 
  
  render: function() {
    var renderedContent = this.template({
      comment: this.model
    });
    
    this.$el.html(renderedContent);
    return this;
  },
  
  deleteComment: function(event) {
    event.preventDefault();
    this.model.destroy();
    //this.remove();
    console.log(this);
  }
})