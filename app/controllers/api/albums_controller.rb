class Api::AlbumsController < ApplicationController

  before_action :require_signed_in, only: [:create, :update, :edit, :destroy, :index]
  before_action :require_album_owner, only: [:update, :destroy]

  def index
    @albums = current_user.albums.includes(photos: [{comments: [:user]}, :likes, :tags, :owner])
  end

  def create
    @album = current_user.albums.new(album_params)

    if @album.save
      render "show"
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @album = Album.includes(photos: [{comments: [:user]}, :likes, :tags, :owner]).find(params[:id])
    if permission_to_view?(@album)
      render "show"
    else
      render json: ["You do not have access to this page"], status: :unprocessable_entity
    end
  end

  def update
    # getting @album in before_action

    if @album.update(album_params)
      @shallow = true
      render "show"
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
     # getting @album in before_action
    @album.destroy
    render "show"
  end

  def public
    @public_albums = Album.all.public_album.includes(photos: [{comments: [:user]}, :likes, :tags, :owner])
  end


  private
  def album_params
    params.require(:album).permit(:title, :date, :description, :location, :visibility)
  end

  def require_album_owner
    @album = Album.find(params[:id])

    if @album.owner != current_user
      render json: ["You do not have access to this page"], status: :unprocessable_entity
    end
  end

end
