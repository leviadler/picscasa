window.Picscasa = {
  helpers: {},
  Models: {},
  Collections: {},
  Subsets: {},
  Views: {},
  Routers: {},
  initialize: function(rootEl) {
    Picscasa.allPhotos = new Picscasa.Collections.Photos()
    Picscasa.allAlbums = new Picscasa.Collections.Albums()

    // get bootsrapped
    var bootstrappedData = JSON.parse($("#bootstrapped-data").html());

    if(Picscasa.CURRENT_USER_ID) {

      Picscasa.userAlbums = new Picscasa.Subsets.UserAlbums(bootstrappedData.userAlbums, {
        parentCollection: Picscasa.allAlbums,
        parse: true
      })

      Picscasa.userPhotos = new Picscasa.Subsets.UserPhotos( bootstrappedData.userPhotos, {
        parentCollection: Picscasa.allPhotos,
        parse: true
      })

      Picscasa.userTags = new Picscasa.Collections.Tags(bootstrappedData.userTags);
    }

    Picscasa.publicAlbums = new Picscasa.Subsets.PublicAlbums(bootstrappedData.publicAlbums, {
      parentCollection: Picscasa.allAlbums,
      parse: true
    });

    Picscasa.users = new Picscasa.Collections.Users({});

    // initialize routers
    new Picscasa.Routers.IndexRouter();
    new Picscasa.Routers.AlbumsRouter({ $rootEl: rootEl });
    new Picscasa.Routers.PhotosRouter({ $rootEl: rootEl });
    new Picscasa.Routers.TagsRouter({ $rootEl: rootEl });
    new Picscasa.Routers.UsersRouter({ $rootEl: rootEl });


    Backbone.history.start();
  }
};
