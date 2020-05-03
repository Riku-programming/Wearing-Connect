class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    # @article = Article.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end


  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if !@friends.empty?
        respond_to do |format|
          format.js {render partial: 'users/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js {render partial: 'users/friend_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js {render partial: 'users/friend_result'}
      end
    end
  end
end
