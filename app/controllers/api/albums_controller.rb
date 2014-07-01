class Api::AlbumsController < ApplicationController

  before_action :require_signed_in, only: [:new, :create, :update, :edit, :destroy, :index]
  before_action :require_album_owner, only: [:edit, :update, :destroy]

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
    @album = Album.find(params[:id])

    if @album.update(album_params)
      render "show"
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id]).destroy
    render "show"
  end

  def public
    @albums = Album.all.public_album.includes(photos: [{comments: [:user]}, :likes, :tags, :owner])
    render "index"
  end


  private
  def album_params
    params.require(:album).permit(:title, :date, :description, :location, :visibility)
  end

  def require_album_owner
    @album = Album.find(params[:id])

    if @album.owner != current_user
      flash[:error] = "You do not have access to that page"
      redirect_to root_url #redirect back?
    end
  end

end
