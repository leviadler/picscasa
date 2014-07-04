Picscasa.Views.AlbumShow = Backbone.View.extend({
  template: JST["albums/show"],

  initialize: function() {
    this._subViews = [];
    this.listenTo(this.model.photos(), "add", this.addPhoto);
    this.listenTo(this.model.photos(), "add remove", this.updateCount);
  },

  render: function() {
    var renderedContent = this.template({
      album: this.model
    });

    this.$el.html(renderedContent);

    var that = this;
    this.model.photos().forEach(function(photo){
      that.addPhoto(photo);
    });

    return this;
  },

  updateCount: function() {
    $("#photo-count").html(this.model.photos().length);
  },

  addPhoto: function(photo) {
    var photoTileView = new Picscasa.Views.PhotoTile({
      model: photo
    });
    this._addSubview(".pictures-index", photoTileView);
  },


  _addSubview: function(selector, subview) {

    this._subViews.push(subview);
    this.$(selector).append(subview.render().$el);

    // don't think need in our case -yet
    subview.delegateEvents();
  },

  remove: function () {
    _(this._subViews).each(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this);
  }
})