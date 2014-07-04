class Api::LikesController < ApplicationController

  before_action :require_signed_in

  def create
    existing_like = Like.find_by(photo_id: params[:photo_id], user_id: current_user.id)

    if existing_like
      render json: ["You already liked this photo!"], status: :unprocessable_entity
    else
      @like = Like.new(photo_id: params[:photo_id], user_id: current_user.id)
      if @like.save
        render json: @like
      else
        render json: @like.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @like = Like.find_by(photo_id: params[:photo_id], user_id: current_user.id).destroy
    if @like
      @like.destroy
      render json: @like
    else
      render json: ["Can't find like"], status: :unprocessable_entity
    end
  end
end
