class PostsController < ApplicationController
  load_and_authorize_resource

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:sucess] = 'Post created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:error] = 'Post not created'
      render :new
    end
  end

  def index
    @posts = Post.where(author_id: params[:user_id]).order(created_at: :desc)
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id]) || 'No posts yet'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy
    redirect_to user_posts_path(params[:user_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(author_id: current_user.id)
  end
end
