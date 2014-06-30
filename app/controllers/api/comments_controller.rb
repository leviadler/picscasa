class Api::CommentsController < ApplicationController

  before_action :require_signed_in
  before_action :require_author, only: :destroy

  def show
    @comment = Comment.find(params[:id])
  end
  
  def index
    @comments = Comment.where(photo_id: params[:photo_id])
  end
  
  def create
    @comment = current_user.comments.new(comment_params);

    if @comment.save
      render "show"
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # no need to load comment - doing that in before action
    @comment.destroy
    render "show"
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :photo_id)
  end

  def require_author
    @comment = Comment.find(params[:id])

    if @comment.user != current_user
      flash[:error] = "You do not have access to that page"
      redirect_to root_url
    end
  end

end
