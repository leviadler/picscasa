class Api::SharesController < ApplicationController
  
  before_action :require_signed_in
  before_action :require_album_owner_and_sharable
  
  # def new
  #   @album = Album.find(params[:album_id])
  #
  #   if @album.public_album?
  #     @url = album_url(@album)
  #   elsif @album.unlisted_album?
  #     @url = album_url(@album, auth_token: @album.auth_token)
  #   end
  # end
  
  def create
    # before action gets our @album
    message = share_params[:message]
    url = share_params[:url]
    
    email_list = share_params[:emails].split(",").map do |email|
      email.strip.downcase
    end.select do |email|
      !!(/.+@.+\..+/i =~ email)
    end.uniq
    
    if email_list.empty?
      render json: ["Please enter atleast one valid email address"], status: :unprocessable_entity
    else
      email = ShareMailer.share_email(@album, message, email_list, url)
      email.deliver
      render json: ["Email sent successfully!"]
    end
    
  end
  
  private
  def share_params
    params.require(:share).permit(:emails, :message, :url)
  end
    
    
  def require_album_owner_and_sharable
    @album = Album.find(params[:album_id])
    
    if @album.owner != current_user
      render json: ["You do not have access to that page"], status: :unprocessable_entity
    elsif  @album.private_album?
      render json: ["Please change your album settings to share."], status: :unprocessable_entity
    end
  end
end
