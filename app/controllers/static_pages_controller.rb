class StaticPagesController < ApplicationController
  def root
    if signed_in?
      @photos = current_user.photos.includes({comments: [:user]}, :likes, :tags, :owner, :album)
      @albums = current_user.albums.includes(photos: [{comments: [:user]}, :likes, :tags, :owner])
      @tags = Tag.with_user_photo_count(current_user)

      @photos_json = render_to_string( template: 'api/photos/index.json.jbuilder')
      @albums_json = render_to_string( template: 'api/albums/index.json.jbuilder')
      @tags_json = render_to_string( template: 'api/tags/index.json.jbuilder')
    end

    @public_albums = Album.all.public_album.includes(photos: [{comments: [:user]}, :likes, :tags, :owner])
    @public_albums_json = render_to_string( template: 'api/albums/public.json.jbuilder')

    render :root, formats: [:html]
  end
end
