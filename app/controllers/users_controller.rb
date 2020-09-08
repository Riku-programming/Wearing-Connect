class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :destroy, :follows, :followers]
  before_action :admin_user, only: [:index, :destroy]
  before_action :set_user, only: [:show, :destroy, :followers, :follows]


  def index
    @users = User.order(admin: :DESC, id: :ASC).page(params[:page]).per(5 * 2)
  end


  def show
    @items = @user.items.all.page(params[:page]).per(5)
    @likes = @user.likes.all.page(params[:page]).per(5)
    @coordinates = @user.coordinates.all.page(params[:page]).per(5)
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
          format.js { render partial: "users/partial/friend_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: "users/partial/friend_result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: "users/partial/friend_result" }
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



  def destroy
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}」は正常に削除されました"
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
