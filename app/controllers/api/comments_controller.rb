class Api::CommentsController < Api::ApplicationController
  def index
    @comments = Comment.all.where(author_id: params.require(:user_id), post_id: params.require(:post_id))
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: { error: 'Comment not saved' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end
end
