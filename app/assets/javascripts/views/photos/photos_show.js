Picscasa.Views.PhotoShow = Backbone.View.extend({
  template: JST['photos/show'],

  initialize: function() {
    this._subViews = [];
    this.listenTo( this.model, "sync", this.render);
    this.listenTo( this.model.comments(), "add remove", this.render );
  },
  
  events: {
    "click a.next-photo": "nextPhoto",
    "click a.prev-photo": "prevPhoto"
  },
  
  nextPhoto: function(event) {
    event.preventDefault();
    console.log(this.model.collection);
    var nextPhoto = this.model.collection.next(this.model);
    if (nextPhoto) {
      Backbone.history.navigate("#/photos/" + nextPhoto.id, {trigger: true })
    }
  },
  
  prevPhoto: function(event) {
    event.preventDefault();
    console.log(this.model.collection);
    var prevPhoto = this.model.collection.prev(this.model);
    if (prevPhoto) {
      Backbone.history.navigate("#/photos/" + prevPhoto.id, {trigger: true })
    }
  },

  render: function() {
    
    // remove subviews
    _(this._subViews).each(function (subview) {
      subview.remove();
    });

    //photo view
    var renderedContent = this.template({
      photo: this.model
    });

    this.$el.html(renderedContent);

    // caption
    var captionView = new Picscasa.Views.CaptionShow({
      model: this.model
    })
    this._addSubview("figcaption", captionView);

    // tags
    var tagsView = new Picscasa.Views.TagsShow({
      model: this.model
    })
    this._addSubview(".tags", tagsView);

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

  // removeComment: function (comment) {
//     var subview = _.find(
//       this._subViews,
//       function (subview) {
//         return subview.model === comment;
//       }
//     );
//
//     this._removeSubview(subview);
//   },


  _addSubview: function(selector, subview) {
    this._subViews.push(subview);

    this.$(selector).append(subview.render().$el);



    // don't think need in our case -yet
    subview.delegateEvents();
  },

  // _removeSubview: function (subview) {
 //    console.log(this._subViews);
 //    subview.remove();
 //
 //    var subviews = this._subViews;
 //    subviews.splice(subviews.indexOf(subview), 1);
 //  },

  remove: function () {
    _(this._subViews).each(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this);
  }
})