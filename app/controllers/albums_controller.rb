class AlbumsController < ApplicationController
  
  before_action :require_signed_in, only: [:new, :create, :update, :edit, :destroy, :index]
  before_action :require_album_owner, only: [:edit, :update, :destroy]
  
  def index
    @albums = current_user.albums
  end
  
  def new
    @album = Album.new
  end
  
  def create
    @album = current_user.albums.new(album_params)

    if @album.save
      flash[:notice] = "Album created!"
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      render :new
    end
  end
  
  def show
    @album = Album.find(params[:id])
    require_permission_for(@album)
  end
  
  def edit
    @album = Album.find(params[:id])
  end
  
  def update
    @album = Album.find(params[:id])
    
    if @album.update(album_params)
      flash[:notice] = "Album updated!"
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id]).destroy
    flash[:notice] = "Album Deleted"
    redirect_to albums_url
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
