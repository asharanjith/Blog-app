class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id]) || 'Post not found'
  end
end
