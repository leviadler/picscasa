class Api::TagsController < ApplicationController

  before_action :require_signed_in

  def index
    @tags = current_user.tags.includes(:photo_taggings)
  end

  def show
    @tag = Tag.friendly.find(params[:id])
    @photos = Photo.joins(:tags, :album).where("albums.owner_id = ? AND tags.id = ? ", current_user.id, @tag.id)
  end

  def destroy
    @photo_taggings = PhotoTagging.joins(:owner).where("albums.owner_id = ? AND photo_taggings.tag_id = ?", current_user.id, params[:id])
    @photo_taggings.destroy_all
    head :ok
  end
end
