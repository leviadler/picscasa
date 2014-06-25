class CommentsController < ApplicationController

  before_action :require_signed_in
  before_action :require_author, only: :destroy

  def create
    c_params = comment_params.merge(photo_id: params[:photo_id])
    @comment = current_user.comments.new(c_params);

    if @comment.save
      flash[:notice] = "Comment Added"
      redirect_to :back
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    # no need to load comment - doing that in before action
    @comment.destroy
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def require_author
    @comment = Comment.find(params[:id])

    if @comment.user != current_user
      flash[:error] = "You do not have access to that page"
      redirect_to root_url
    end
  end

end
