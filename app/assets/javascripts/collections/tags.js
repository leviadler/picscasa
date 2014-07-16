Picscasa.Collections.Tags = Backbone.Collection.extend({
  url: "api/tags",

  model: Picscasa.Models.Tag,

  getAndFetch: function (id, callback) {
    var tags = this;
    var tag = this.get(id);

    if (!tag) {
      tag = new this.model({
        id: id
      });
      tag.collection = tags;
    }
    tag.fetch({
      success: function () {
        tags.add(tag);
        callback(tag);
      }
    });
  }
})