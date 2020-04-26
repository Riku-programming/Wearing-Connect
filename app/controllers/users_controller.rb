class UsersController < ApplicationController


  def show
    @user = current_user
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def my_friends
    @friends = currrent_user.friends
  end

  def search
    render json: params[:friend]
  end

end
