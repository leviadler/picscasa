Picscasa.Collections.Users = Backbone.Collection.extend({
  url: "api/users",

  model: Picscasa.Models.User,

  getOrFetch: function (id, callback) {
    var users = this;
    var user = this.get(id);

    if (!user) {
      console.log("fetching");
      user = new this.model({
        id: id
      });
      user.collection = users;
      user.fetch({
        success: function () {
          users.add(user);
          callback(user);
        }
      });
    } else {
      callback(user);
    }
  }
})