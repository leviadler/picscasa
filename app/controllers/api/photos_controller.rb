class Api::PhotosController < ApplicationController

  before_action :require_signed_in, only: [:new, :create, :destroy, :index, :update]
  before_action :require_photo_owner, only: [:update, :destroy]

  def index
    @photos = current_user.photos.includes({comments: [:user]}, :likes, :tags, :owner)
  end

  def show
    @photo = Photo.includes({comments: [:user]}, :likes, :tags, :owner).find(params[:id])
    if permission_to_view?(@photo.album)
      # this is very inacurate b/c we refresh with every like and comment
      # - even now this may not work - will prob need to do something on the
      # backbone end to make it update the count
      @photo.view_count += 1
      @photo.save!
      render "show"
    else
      render json: ["You do not have access to this page"], status: :unprocessable_entity
    end
  end

  def update
    # getting @photo in before action

    if @photo.update(photo_params)
      render json: @photo
    else
      render json: @photo.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    # getting @photo in before action
    @photo.destroy
    render "show"
  end


  # will only handle one image
  def create

    # check that uploading to an album that belongs to me
    if Album.find(image_params[:album_id]).owner != current_user
      render json: ["Error: Not your album"], status: :unprocessable_entity
    end

    @photo = Photo.new(image_params)


    if @photo.save
      render "show"
    else
      render json: @photo.errors.full_messages, status: :unprocessable_entity
    end
  end




#   multiple images API'd YET!
#   def create
#
#     @album = Album.find(params[:album_id])
#
#     @album.photos.new(image_params)
#
#
#     if @album.save
#       flash[:notice] = "Uploaded photos successfully!"
#       redirect_to album_url(params[:album_id])
#     else
#       flash[:error] = @album.errors.full_messages
#       redirect_to album_url(params[:album_id])
#     end
#
#     # photo_params[:images].each do |image|
# #       photo = Photo.new(image: image, album_id: params[:album_id])
# #
# #       if photo.save
# #         num_pics += 1
# #       else
# #         flash[:error] = "One or more of your files failed to upload"
# #         redirect_to album_url(params[:album_id])
# #       end
# #     end
# #
# #     flash[:notice] = "Uploaded #{num_pics} photos successfully!"
# #     redirect_to album_url(params[:album_id])
#
#
#     #for single photo:
#     # @photo = Photo.new(photo_params.merge!(album_id: params[:album_id]))
# #
# #     if @photo.save
# #       flash[:notice] = "Photo uploaded!"
# #       redirect_to photo_url(@photo)
# #     else
# #       flash[:error] = @photo.errors.full_messages
# #       render :new
# #     end
#   end





  private
  def image_params
    params.require(:photo).permit(:image, :album_id)
  end

  # for multiple
  # def image_params
#     p = params.require(:photo).permit(images:[])
#     p[:images].map do |file|
#       {image: file}
#     end
#   end

  def photo_params
    params.require(:photo).permit(:caption, :tag_list)
  end

  def require_photo_owner
    @photo = Photo.find(params[:id])

    if @photo.owner != current_user
      render json: ["You do not have access to this page"], status: :unprocessable_entity
    end
  end

end
