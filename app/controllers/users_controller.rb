class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followers, :follows]


  def show
    # @item = Item.find(params[:id])
    @items = @user.items.all.page(params[:page]).per(5)
    @likes = @user.likes.all.page(params[:page]).per(5)
    @friendship = Friendship.new
    @users = @user.followings
  end

  def like
    @user = current_user
    @likes = @user.likes.all.page(params[:page]).per(5)
  end



  def search
    if params[:user].present?
      @users = User.search(params[:user])
      @users = current_user.except_current_user(@users)
      if @users
        respond_to do |format|
          format.js {render partial: 'users/partial/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js {render partial: 'users/partial/friend_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js {render partial: 'users/partial/friend_result'}
      end
    end
  end

  def favorite
    @favorite_items = @user.favorites_items
  end

  def follows
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  def like_items; end


  private

  def set_user
    @user = User.find(params[:id])
  end
end
