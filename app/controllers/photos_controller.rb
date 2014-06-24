class PhotosController < ApplicationController
  
  def new
    @album = Album.find(params[:album_id])
  end
  
  def create
    
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
    
end
