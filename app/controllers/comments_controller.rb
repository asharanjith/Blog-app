class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(post:, author: current_user, text: comment_params[:text])
    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
