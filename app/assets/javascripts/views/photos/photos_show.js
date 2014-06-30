Picscasa.Views.PhotoShow = Backbone.View.extend({
  template: JST['photos/show'],

  initialize: function() {
    this._subViews = [];
    this.listenTo( this.model, "sync", this.render);
    this.listenTo( this.model.comments(), "add", this.addComment );
    this.listenTo( this.model.comments(), "remove", this.removeComment);
  },

  render: function() {
    //photo view
    var renderedContent = this.template({
      photo: this.model
    });

    this.$el.html(renderedContent);
    
    // new comment form
    if(Picscasa.helpers.signedIn()) {
      var commentNewView = new Picscasa.Views.CommentsNew({
        model: this.model
      });

      this._addSubview(".comments", commentNewView);
    };

    //comments
    var that = this;
    this.model.comments().forEach( function(comment) {
      that.addComment(comment)
    });
      
    
    return this;
  },
  
  
  addComment: function (comment) {
    var commentsShow = new Picscasa.Views.CommentsShow({ 
      model: comment 
    });
    this._addSubview(".comments", commentsShow);
  },

  removeComment: function (comment) {
    var subview = _.find(
      this._subViews,
      function (subview) {
        return subview.model === comment;
      }
    );

    this._removeSubview(subview);
  },
  
  
  _addSubview: function(selector, subview) {
    this._subViews.push(subview);
    
    this.$(selector).append(subview.render().$el);
    
    
    
    // don't think need in our case -yet
    subview.delegateEvents();
  },
  
  _removeSubview: function (subview) {
    console.log(this._subViews);
    subview.remove();

    var subviews = this._subViews;
    subviews.splice(subviews.indexOf(subview), 1);
  },
  
  remove: function () {
    _(this._subViews).each(function (subview) {
      subview.remove();
    });
    
    Backbone.View.prototype.remove.call(this);
  }
})