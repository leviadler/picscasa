Picscasa.Views.PhotoShow = Backbone.View.extend({
  template: JST['photos/show'],

  initialize: function() {
    this._subViews = [];
    // this is causing extra comment show views and preventing removal of comment upon delete
    // b/c now there is more than one view per comment and it might be removing one thats not on the screen
    // but will prob still need this for other things that get updated on the photo model
    // one way to 'fix' this is to remove it in the comment show view - this guarentees a smooth user experience but will
    // have subviews lying around until entire page is switched up.
    //this.listenTo( this.model, "sync", this.render);
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



    // comments
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