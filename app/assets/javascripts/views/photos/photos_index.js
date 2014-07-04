Picscasa.Views.PhotosIndex = Backbone.View.extend({
  template: JST['photos/index'],

  initialize: function(options) {
    this.title = options.title;
    this._subViews = [];
    //this.listenTo(this.collection, "sync", this.render); //change to add once bootstraped
    //this.listenTo(this.collection, "add", this.addPhoto) // not working...
  },

  render: function() {
    var renderedContent = this.template({
      //photos: this.collection.photos(),
      photos: this.collection,
      title: this.title
    });

    this.$el.html(renderedContent);

    var that = this;
    this.collection.forEach(function(photo){
      console.log(photo);
      that.addPhoto(photo);
    });

    return this;
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