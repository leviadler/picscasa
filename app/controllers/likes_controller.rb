class LikesController < ApplicationController
 
  before_action :require_signed_in
   
  def create
    existing_like = Like.find_by(photo_id: params[:photo_id], user_id: current_user.id)
    
    if existing_like
      flash[:error] = "You already liked this photo!"
    else
      @like = Like.new(photo_id: params[:photo_id], user_id: current_user.id)
      if @like.save
        flash[:notice] = "You liked this photo!"
      else
        flash[:error] = @like.errors.full_messages
      end
    end
    
    redirect_to :back
  end
  
  def destroy
    @like = Like.find_by(photo_id: params[:photo_id], user_id: current_user.id).destroy
    redirect_to :back
  end
end
