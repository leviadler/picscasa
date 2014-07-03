Picscasa.Views.TagsIndex = Backbone.View.extend({
  template: JST["tags/index"],
  
  initialize: function() {
    this.listenTo(this.collection, "sync remove", this.render);
  },
  
  events: {
    "click button.delete" : "deleteTag"
  },
  
  render: function() {
    var renderedContent = this.template({
      tags: this.collection.models
    });
    
    this.$el.html(renderedContent);
    return this;
  },
  
  deleteTag: function(event) {
    event.preventDefault();
    
    var id = $(event.currentTarget).data('id') // .attr('data-id')
    this.collection.get(id).destroy();
  }
})