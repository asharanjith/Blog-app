class PostsController < ApplicationController
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
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts.includes(:comments)
  end
  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id]) || 'No posts yet'
  end
  private
  def post_params
    params.require(:post).permit(:title, :text).merge(author_id: current_user.id)
  end
end
