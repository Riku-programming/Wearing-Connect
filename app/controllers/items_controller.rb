class ItemsController < ApplicationController

  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @items = Item.paginate(page: params[:page], per_page: 5)
  end

  def new
    @item = Item.new
  end

  def edit
  end



  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      flash[:success] = "item was successfully created"
      redirect_to items_path
    else
      render 'new'
    end
  end


  def update
    if @item.update(item_params)
      flash[:success] = "item was successfully updated"
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def show
    # # fixme current_userではなくUser.find([:params])かも
    # if @item.user_id == current_user.id
    #   @user = current_user
    # else
    #   @user = User.find(params[:id])
    # end

    # @user = current_user
    @user = User.find(params[:id])
    @items = @user.items.paginate(page: params[:page], per_page: 5)
  end

  # fixme flashメッセージがアプリケーションを通して表示されない
  def destroy
    @item.destroy
    flash[:danger] = "item was successfully deleted"
    redirect_to items_path
  end

  def my_items
  end


  def search
    if params[:keyword].present?
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      if @items.count >= 1
        respond_to do |format|
          format.js {render partial: 'item_result'}
        end
      elsif @items.count == 0
        respond_to do |format|
          flash.now[:alert] = "Couldn't find item"
          format.js {render partial: 'item_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a item name to search"
        format.js {render partial: 'item_result'}
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    # fixme image => img
    params.require(:item).permit(:item_name, :price, :url, :image, :remove_image)
  end

  def require_same_user
    if current_user != @item.user
      flash[:danger] = "You can only edit delete your own items"
      redirect_to root_path
    end
  end




end
