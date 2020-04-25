class UsersController < ApplicationController


  def show
    @user = current_user
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

end
