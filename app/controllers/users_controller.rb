class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if params[:id] == 'Sign out'
      redirect_to root_path
    else
      @user = User.find_by(id: params[:id]) || 'User not found'
    end
  end
end
