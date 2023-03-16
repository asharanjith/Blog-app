class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id]) || 'User not found'
    @posts = @user.posts.order(created_at: :desc).limit(3)
  end
end
