class SharesController < ApplicationController
  
  before_action :require_signed_in
  before_action :require_album_owner_and_sharable
  
  def new
    @album = Album.find(params[:album_id])
    
    if @album.public_album?
      @url = album_url(@album)
    elsif @album.unlisted_album?
      @url = album_url(@album, auth_token: @album.auth_token)
    end
  end
  
  def create
    album = Album.find(params[:album_id])
    message = share_params[:message]
    
    email_list = share_params[:emails].split(",").map do |email|
      email.strip.downcase
    end.select do |email|
      !!(/.+@.+\..+/i =~ email)
    end.uniq
    
    if email_list.empty?
      flash.now[:error] = "Please enter atleast one valid email address"
      render :new
    else
      email = ShareMailer.rails_share_email(album, message, email_list)
      email.deliver
    end
    
    flash[:notice] = "Email sent!"
    redirect_to album_url(album)

  end
  
  private
  def share_params
    params.require(:share).permit(:emails, :message)
  end
    
    
  def require_album_owner_and_sharable
    @album = Album.find(params[:album_id])
    
    if @album.owner != current_user
      flash[:error] = "You do not have access to that page"
      redirect_to root_url #redirect back?
    elsif  @album.private_album?
      flash[:error] = "Please change your album settings to share."
      redirect_to album_url(@album)
    end
  end
end
