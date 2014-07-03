Picscasa.Views.AlbumShare = Backbone.View.extend({
  template: JST["shares/new"],
  
  events: {
    "submit form": "sendEmail"
  },
  
  render: function() {
    var renderedContent = this.template({
      album: this.model
    });
    
    this.$el.html(renderedContent);
    return this;
  },
  
  sendEmail: function(event) {
    event.preventDefault();
    
    var formData = $(event.currentTarget).serializeJSON();
    
    var that = this;
    
    $.ajax({
      url: "/api/albums/" + this.model.id + "/share",
      method: "POST",
      data: formData,
      success: function(result) {
        console.log("here");
        Backbone.history.navigate("#/albums/" + that.model.id, {trigger: true});
        Picscasa.helpers.renderFlash("Email sent!", "success");
      },
      error: function(response) {
        Picscasa.helpers.renderFlash(response.responseJSON.join(" - "), "error");
      }
    })
  }
})