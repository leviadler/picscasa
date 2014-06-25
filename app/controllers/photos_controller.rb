class PhotosController < ApplicationController

  def new
    @album = Album.find(params[:album_id])
  end

  def create
    num_pics = 0

    photo_params[:images].each do |image|
      @photo = Photo.new(image: image, album_id: params[:album_id])

      if @photo.save
        num_pics += 1
      else
        flash[:error] = "One or more of your files failed to upload"
        redirect_to album_url(params[:album_id])
      end
    end

    flash[:notice] = "Uploaded #{num_pics} photos successfully!"
    redirect_to album_url(params[:album_id])

    #for single photo:
    # @photo = Photo.new(photo_params.merge!(album_id: params[:album_id]))
#
#     if @photo.save
#       flash[:notice] = "Photo uploaded!"
#       redirect_to photo_url(@photo)
#     else
#       flash[:error] = @photo.errors.full_messages
#       render :new
#     end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private
  def photo_params
    params.require(:photo).permit(images:[]) #?????
  end

end
