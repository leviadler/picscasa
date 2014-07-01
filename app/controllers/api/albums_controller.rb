class Api::AlbumsController < ApplicationController

  before_action :require_signed_in, only: [:new, :create, :update, :edit, :destroy, :index]
  before_action :require_album_owner, only: [:edit, :update, :destroy]

  def index
    @albums = current_user.albums
    render json: @albums
  end

  def create
    @album = current_user.albums.new(album_params)

    if @album.save
      render json: @album
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @album = Album.find(params[:id])
    require_permission_for(@album)
    render json: @album
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id]).destroy
    render json: @album
  end

  def public
    @albums = Album.all.public_album
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
